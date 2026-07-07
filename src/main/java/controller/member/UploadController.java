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
import service.member.MyPageService;
import service.member.MyPageServiceImpl;

@WebServlet("/member/uploadProfile")
@MultipartConfig
public class UploadController extends HttpServlet {

    private final MyPageService myPageService = new MyPageServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO user = session != null ? (UserDTO) session.getAttribute("loginUser") : null;
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("unauthorized");
            return;
        }

        Part filePart = request.getPart("profile");
        if (filePart == null || filePart.getSize() == 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("no_file");
            return;
        }

        String uploadDir = request.getServletContext().getRealPath("/member/upload/");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        filePart.write(uploadDir + File.separator + fileName);

        user.setProfileImage(fileName);
        myPageService.updateProfile_image(user);
        session.setAttribute("loginUser", user);

        response.getWriter().write(fileName);
    }
}
