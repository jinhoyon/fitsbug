package controller.trainer;

import service.trainer.LoginService;
import service.trainer.LoginService.LoginResult;
import service.trainer.LoginServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/trainer/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/trainer/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginService service = new LoginServiceImpl();

        try {
            LoginResult result = service.loginTrainer(email, password);

            if (result.isSuccess()) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", result.getUser());
                session.setAttribute("loginTrainer", result.getTrainer());
                response.sendRedirect(request.getContextPath() + "/trainer/dashboard");
            } else {
                request.setAttribute("error", getLoginErrorMessage(result.getStatus()));
                request.getRequestDispatcher("/trainer/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "서버 오류가 발생했습니다.");
            request.getRequestDispatcher("/trainer/login.jsp").forward(request, response);
        }
    }

    private String getLoginErrorMessage(LoginResult.Status status) {
        switch (status) {
            case ACCOUNT_NOT_FOUND:
                return "존재하지 않는 계정입니다.";
            case NOT_TRAINER:
                return "트레이너 계정이 아닙니다.";
            case TRAINER_PROFILE_NOT_FOUND:
                return "트레이너 프로필 정보가 없습니다.";
            case WRONG_PASSWORD:
                return "비밀번호가 올바르지 않습니다.";
            default:
                return "이메일 또는 비밀번호가 올바르지 않습니다.";
        }
    }
}
