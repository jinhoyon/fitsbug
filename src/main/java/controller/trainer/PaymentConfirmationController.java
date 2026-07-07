package controller.trainer;

import dto.common.TossDTO;
import dto.common.UserDTO;
import org.json.JSONObject;
import service.common.TossPaymentService;
import service.common.TossPaymentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@WebServlet("/payment/confirm")
public class PaymentConfirmationController extends HttpServlet {

    private final TossPaymentService tossPaymentService = new TossPaymentServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject requestBody = new JSONObject(sb.toString());
        String paymentKey = requestBody.getString("paymentKey");
        String orderId = requestBody.getString("orderId");
        long amount = requestBody.getLong("amount");

        try {
            JSONObject tossResponse = tossPaymentService.confirmPayment(paymentKey, orderId, amount);

            TossDTO dto = new TossDTO();
            dto.setPaymentKey(tossResponse.getString("paymentKey"));
            dto.setOrderId(tossResponse.getString("orderId"));
            dto.setAmount(tossResponse.getLong("totalAmount"));
            dto.setStatus(tossResponse.getString("status"));
            dto.setMethod(tossResponse.optString("method", null));
            dto.setApprovedAt(tossResponse.optString("approvedAt", null));

            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("loginUser") != null) {
                UserDTO user = (UserDTO) session.getAttribute("loginUser");
                dto.setUserId(user.getId());
            }

            tossPaymentService.saveToss(dto);

            response.setStatus(200);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(tossResponse.toString());
        } catch (Exception e) {
            response.setStatus(500);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}");
        }
    }
}
