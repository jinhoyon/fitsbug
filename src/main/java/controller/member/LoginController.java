package controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.UserDTO;
import dto.common.TrainerDTO;
import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import org.apache.ibatis.session.SqlSession;
import service.member.UserService;
import service.member.UserServiceImpl;
import util.MybatisSqlSessionFactory;

@WebServlet("/member/login")
public class LoginController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("loginUser") != null) {
            response.sendRedirect(request.getContextPath() + "/member/main");
            return;
        }
        request.getRequestDispatcher("/member/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. 유효성 검사 (입력값 확인)
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMsg", "이메일과 비밀번호를 입력해주세요.");
            request.getRequestDispatcher("/member/login.jsp").forward(request, response);
            return;
        }

        try {
            // 2. 서비스 계층을 통한 로그인 시도 (수정된 UserDTO 규격에 맞춰 작동)
            UserDTO loginUser = userService.login(email.trim(), password);

            // 3. 로그인 결과 처리
            if (loginUser != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", loginUser);
                session.setAttribute("loginEmail", email.trim());

                // 역할(Role)별 리다이렉트
                String role = loginUser.getRole();
                if ("GYM".equals(role)) {
                	session.setAttribute("gymId", loginUser.getOtherId());
                    response.sendRedirect(request.getContextPath() + "/gym/dashboard");
                } else if ("TRAINER".equals(role)) {
                    try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
                        TrainerDAO trainerDAO = new TrainerDAOImpl();
                        TrainerDTO trainer = trainerDAO.findByUserId(sqlSession, loginUser.getId());
                        if (trainer != null) {
                            session.setAttribute("loginTrainer", trainer);
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/trainer/dashboard");
                } else if ("ADMIN".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/admin/main");
                } else {
                    response.sendRedirect(request.getContextPath() + "/member/main");
                }
            } else {
                // 로그인 실패 (비밀번호 불일치 등)
                request.setAttribute("errorMsg", "아이디 또는 비밀번호가 틀렸습니다.");
                request.getRequestDispatcher("/member/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "로그인 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            request.getRequestDispatcher("/member/login.jsp").forward(request, response);
        }
    }
}