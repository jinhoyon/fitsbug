package controller.trainer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/payment/checkout")
public class PaymentCheckout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Optional: load product / lesson / membership info
        // request.setAttribute("lesson", lessonData);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/trainer/payment/checkout.jsp");
        dispatcher.forward(request, response);
    }
}