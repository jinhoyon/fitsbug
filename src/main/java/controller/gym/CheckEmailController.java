package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import service.gym.GymInfoEditService;
import service.gym.GymInfoEditServiceImpl;

@WebServlet("/gym/checkEmail")
public class CheckEmailController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CheckEmailController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        String emailId = request.getParameter("emailId");

        // 🔥 null / 빈값 방어
        if (emailId == null || emailId.trim().isEmpty()) {
            response.getWriter().write("invalid");
            return;
        }

        GymInfoEditService service = new GymInfoEditServiceImpl();

        boolean available = service.isEmailAvailable(emailId.trim());

        response.getWriter().write(available ? "available" : "duplicate");
    }
}