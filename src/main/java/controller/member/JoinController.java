package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/member/join")
public class JoinController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/member/join.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("password", request.getParameter("password"));
        session.setAttribute("nickname", request.getParameter("nickname"));
        session.setAttribute("name", request.getParameter("name"));
        session.setAttribute("phone", request.getParameter("phone"));
        session.setAttribute("age",    request.getParameter("age"));
        session.setAttribute("gender", request.getParameter("gender"));
        session.setAttribute("role", request.getParameter("role"));

        response.sendRedirect(request.getContextPath() + "/member/step2");
    }
}