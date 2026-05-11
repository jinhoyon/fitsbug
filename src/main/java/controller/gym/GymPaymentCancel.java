package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.gym.GymPaymentService;
import service.gym.GymPaymentServiceImpl;

@WebServlet("/gym/paymentCancel")
public class GymPaymentCancel extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymPaymentCancel() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");
        
        String orderId = request.getParameter("orderId");
        String reason = request.getParameter("reason");

        if (reason == null || reason.trim().isEmpty()) {
            reason = "사용자 결제 취소";
        }

        try {
        	GymPaymentService service = new GymPaymentServiceImpl();
        	
            service.cancelPayment(orderId, reason);

            response.sendRedirect(
                request.getContextPath() + "/gym/sales?cancel=success"
            );

        } catch (Exception e) {
            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath() + "/gym/sales?cancel=fail"
            );
        }
    }
}