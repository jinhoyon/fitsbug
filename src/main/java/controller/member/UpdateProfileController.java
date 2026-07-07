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

import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.common.UserDTO;

@WebServlet("/member/updateProfile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 5 * 5
)
public class UpdateProfileController extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        String nickname = req.getParameter("nickname");
        String password = req.getParameter("password");

        // 🔥 파일 처리
        Part filePart = req.getPart("profile_image");

        String fileName = null;

        if(filePart != null && filePart.getSize() > 0){

            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = req.getServletContext().getRealPath("/member/upload");

            File dir = new File(uploadPath);
            if(!dir.exists()) dir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);

            loginUser.setProfileImage(fileName);
        }

        // 🔥 텍스트 값
        loginUser.setNickname(nickname);

        if(password != null && !password.isEmpty()){
            loginUser.setPassword(password);
        }

        UserDAO dao = new UserDAOImpl();
        int result = dao.update(loginUser);

        if(result > 0){
            session.setAttribute("loginUser", loginUser);
            resp.getWriter().write("ok");
        }else{
            resp.getWriter().write("fail");
        }
    }
}