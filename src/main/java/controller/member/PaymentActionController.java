package controller.member;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import service.member.PaymentService;
import service.member.PaymentServiceImpl;

@WebServlet("/member/paymentAction")
public class PaymentActionController extends HttpServlet {

    private PaymentService service = new PaymentServiceImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("text/plain;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if(session == null){
            resp.getWriter().write("not_login");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("loginUser");
        if(user == null){
            resp.getWriter().write("not_login");
            return;
        }

        String orderId = req.getParameter("orderId");
        String action  = req.getParameter("action");

        if(orderId == null || action == null){
            resp.getWriter().write("invalid");
            return;
        }

        try {

            if("cancel".equals(action)){
                service.requestCancel(orderId);
            } else if("refund".equals(action)){
                service.requestRefund(orderId);
            } else {
                resp.getWriter().write("invalid_action");
                return;
            }

            resp.getWriter().write("ok");

        } catch(Exception e){
            e.printStackTrace();
            resp.getWriter().write("error");
        }
    }
}