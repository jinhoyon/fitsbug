package controller.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.common.UserDTO;
import service.member.UserService;
import service.member.UserServiceImpl;
import util.PasswordUtil;

@WebServlet("/member/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
public class UpdateProfileController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        UserDTO loginUser = session != null ? (UserDTO) session.getAttribute("loginUser") : null;
        if (loginUser == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("unauthorized");
            return;
        }

        String nickname = req.getParameter("nickname");
        String password = req.getParameter("password");

        Part filePart = req.getPart("profile_image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = req.getServletContext().getRealPath("/member/upload");
            File dir = new File(uploadPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);
            loginUser.setProfileImage(fileName);
        }

        loginUser.setNickname(nickname);

        if (password != null && !password.isEmpty()) {
            loginUser.setPassword(PasswordUtil.hash(password));
        }

        int result = userService.update(loginUser);

        if (result > 0) {
            session.setAttribute("loginUser", loginUser);
            resp.getWriter().write("ok");
        } else {
            resp.getWriter().write("fail");
        }
    }
}
