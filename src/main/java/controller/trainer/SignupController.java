package controller.trainer;

import at.favre.lib.crypto.bcrypt.BCrypt;
import dto.trainer.UserDTO;
import service.trainer.SignupService;
import service.trainer.SignupServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/trainer/signup")
public class SignupController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("pendingTrainerUserId") != null) {
            int userId = (int) session.getAttribute("pendingTrainerUserId");
            SignupService service = new SignupServiceImpl();
            UserDTO existing = service.getUserById(userId);
            if (existing != null) {
                request.setAttribute("prefill", existing);
            }
        }
        request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) {
            email = request.getParameter("emailId");
        }
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String nickname = request.getParameter("nickname");
        int age = 0;
        try { age = Integer.parseInt(request.getParameter("age")); } catch (Exception ignored) {}
        String gender = request.getParameter("gender");
//        String profileImg = request.getParameter("profileImg");
        String provider = request.getParameter("provider");
        String providerId = request.getParameter("providerId");
        if (provider != null && provider.isEmpty()) {
            provider = null;
        }
        if (providerId != null && providerId.isEmpty()) {
            providerId = null;
        }

        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        UserDTO dto = new UserDTO();
        dto.setName(name);
        dto.setEmail(email);
        dto.setPassword(hashedPassword);
        dto.setPhone(phone);
        dto.setNickname(nickname);
//        dto.setProfileImg(profileImg);
        dto.setAge(age);
        dto.setGender(gender);
        dto.setRole(UserDTO.UserRole.TRAINER);
        dto.setProvider(provider);
        dto.setProviderId(providerId);

        SignupService service = new SignupServiceImpl();
        HttpSession session = request.getSession();
        Integer existingUserId = (Integer) session.getAttribute("pendingTrainerUserId");

        try {
            if (existingUserId != null) {
                // User already created — just update their info
                dto.setId(existingUserId);
                service.updateUser(dto);
            } else {
                // First time — insert new user
                int result = service.signupTrainer(dto);
                if (result <= 0) {
                    request.setAttribute("error", "회원가입 실패");
                    request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
                    return;
                }
                session.setAttribute("pendingTrainerUserId", dto.getId());
            }
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step2");

        } catch (Exception e) {
            e.printStackTrace();

            String cause = e.getMessage() != null ? e.getMessage() : "";
            // MariaDB/MySQL error 1062 = Duplicate entry
            if (cause.contains("Duplicate entry") || cause.contains("1062")) {
                request.setAttribute("isDuplicate", true);
                request.setAttribute("error", "이미 사용 중인 이메일입니다. 다른 이메일을 사용하거나 로그인해 주세요.");
            } else {
                request.setAttribute("error", "서버 오류로 회원가입에 실패했습니다. 잠시 후 다시 시도해 주세요.");
            }
            request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
        }
    }
}
