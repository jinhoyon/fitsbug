package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/member/step2")
public class Step2Controller extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("/member/step2.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        session.setAttribute("height", request.getParameter("height"));
        session.setAttribute("weight", request.getParameter("weight"));
        session.setAttribute("diet", request.getParameter("diet"));

        response.sendRedirect(request.getContextPath() + "/member/step3");
    }
}