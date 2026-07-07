package controller.trainer;

import util.TossPaymentsConfig;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payment/checkout")
public class PaymentCheckoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("tossClientKey", TossPaymentsConfig.getClientKey());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/trainer/payment/checkout.jsp");
        dispatcher.forward(request, response);
    }
}
