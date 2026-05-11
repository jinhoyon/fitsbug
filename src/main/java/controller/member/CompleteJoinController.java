package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/complete")
public class CompleteJoinController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String workout = request.getParameter("workout");
        session.setAttribute("workout", workout);

        // ✅ /main 컨트롤러로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/member/main");
    }
}
