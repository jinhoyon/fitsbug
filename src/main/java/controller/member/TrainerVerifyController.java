package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/member/trainerVerify")
public class TrainerVerifyController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/member/trainerVerify.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String exp = req.getParameter("experience");
        String career = req.getParameter("career");
        String cert = req.getParameter("certificate");

        // TODO: DAO 저장

        resp.sendRedirect(req.getContextPath() + "/member/main");
    }
}