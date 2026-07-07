package controller.trainer;

import dto.common.TossDTO;
import org.json.JSONObject;
import service.common.TossPaymentService;
import service.common.TossPaymentServiceImpl;
import service.trainer.TrainerPaymentService;
import service.trainer.TrainerPaymentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/payment/cancel")
public class PaymentCancelController extends HttpServlet {

    private final TossPaymentService tossPaymentService = new TossPaymentServiceImpl();
    private final TrainerPaymentService paymentService = new TrainerPaymentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        TossDTO payment = paymentService.getPaymentByOrderId(orderId);
        request.setAttribute("payment", payment);
        request.getRequestDispatcher("/trainer/payment/cancel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);

        JSONObject requestBody = new JSONObject(sb.toString());
        String paymentKey = requestBody.getString("paymentKey");
        String cancelReason = requestBody.getString("cancelReason");

        try {
            JSONObject tossResponse = tossPaymentService.cancelPayment(paymentKey, cancelReason);
            tossPaymentService.updateStatus(tossResponse.getString("orderId"), "CANCELED");

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
