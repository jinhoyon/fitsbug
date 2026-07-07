package controller.member;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.UserDTO;
import dto.common.Payment;
import service.member.PaymentService;
import service.member.PaymentServiceImpl;

@WebServlet("/member/payment")
public class PaymentController extends HttpServlet {

    private final PaymentService service = new PaymentServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        resp.setContentType("application/json;charset=UTF-8");

        if (user == null) {
            resp.getWriter().write("{\"error\":\"not_login\"}");
            return;
        }

        int amount = Integer.parseInt(req.getParameter("amount"));
        String productName = req.getParameter("productName");
        String orderId = "MEM-" + user.getId() + "-" + System.currentTimeMillis();

        Payment payment = new Payment();
        payment.setUserId(user.getId());
        payment.setUserName(user.getName());
        payment.setPaymentPrice(amount);
        payment.setOrderId(orderId);
        payment.setMethod("TOSS");
        payment.setPaymentType("MEMBERSHIP");
        service.createPayment(payment);

        String safeName = productName == null ? "" : productName.replace("\\", "\\\\").replace("\"", "\\\"");
        String json = "{"
                + "\"orderId\":\"" + orderId + "\","
                + "\"amount\":" + amount + ","
                + "\"productName\":\"" + safeName + "\""
                + "}";

        resp.getWriter().write(json);
    }
}
