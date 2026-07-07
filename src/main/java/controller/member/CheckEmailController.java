package controller.member;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.member.UserService;
import service.member.UserServiceImpl;

@WebServlet("/member/checkEmail")
public class CheckEmailController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        if (email == null || email.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        boolean exists = userService.isEmailExists(email);

        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write("{\"exists\":" + exists + "}");
    }
}
