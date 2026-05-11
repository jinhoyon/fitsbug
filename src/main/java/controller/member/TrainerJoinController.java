package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/member/trainerJoin")
public class TrainerJoinController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/member/trainerJoin.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 데이터 받기
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");

        // ⭐ 여기서 DB 저장 처리

        // 완료 후 인증 페이지 이동
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/member/trainerVerify"));
    }
}