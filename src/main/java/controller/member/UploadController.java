package controller.member;

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
import service.member.MyPageServiceImpl;

@WebServlet("/member/uploadProfile")
@MultipartConfig
public class UploadController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("profile");

        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String path = request.getServletContext().getRealPath("/member/upload/");

        filePart.write(path + fileName);

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        user.setProfileImage(fileName);

        // DB 업데이트
        new MyPageServiceImpl().updateProfile_image(user);

        response.getWriter().write(fileName);
    }
}