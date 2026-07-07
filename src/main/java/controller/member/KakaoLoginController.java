package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.common.UserDTO;
import util.KakaoUtil;

@WebServlet("/member/kakaoLogin")
public class KakaoLoginController extends HttpServlet {

    private UserDAO userDao = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        String accessToken = KakaoUtil.getAccessToken(code);
        String email = KakaoUtil.getUserEmail(accessToken);

        if (email == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        UserDTO user = userDao.findByEmail(email);

        if (user == null) {
            user = new UserDTO();
            user.setEmail(email);
            user.setNickname("카카오회원_" + System.currentTimeMillis() % 10000);
            user.setEmailVerified(true);
            user.setRole("MEMBER");
            user.setProvider("kakao");
            userDao.insertSocial(user);
            user = userDao.findByEmail(email);
        }

        if (user != null && user.isDeleted()) {
            request.setAttribute("errorMsg", "탈퇴한 계정입니다.");
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loginUser",  user);
        session.setAttribute("loginEmail", email);
        response.sendRedirect(request.getContextPath() + "/member/main");
    }
}
