package controller.gym;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.UserDTO;
import service.gym.GymInfoEditService;
import service.gym.GymInfoEditServiceImpl;

@WebServlet("/gym/changePassword")
public class GymChangePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymChangePassword() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        } 

        Integer gymId = user.getOtherId();
        String password = request.getParameter("password");

        if (password == null || password.trim().isEmpty()) {
            response.getWriter().write("empty_password");
            return;
        }

        GymInfoEditService service = new GymInfoEditServiceImpl();

        Map<String, Object> param = new HashMap<>();
        param.put("userId", user.getId());
        param.put("password", password);

        int result = service.updatePassword(param);

        response.getWriter().write(result > 0 ? "success" : "fail");
    }
}