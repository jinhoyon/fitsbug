package controller.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.common.UserDTO;
import dto.member.TrainerReviewDTO;
import service.member.TrainerReviewService;
import service.member.TrainerReviewServiceImpl;

@WebServlet("/member/review")
@MultipartConfig
public class TrainerReviewController extends HttpServlet {
    private TrainerReviewService service = new TrainerReviewServiceImpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDTO user = (UserDTO) req.getSession().getAttribute("loginUser");

        if(user == null){
            resp.getWriter().write("로그인 필요");
            return;
        }

        int rating = Integer.parseInt(req.getParameter("rating"));
        String content = req.getParameter("content");
        int trainerId = Integer.parseInt(req.getParameter("trainerId"));

        Part filePart = req.getPart("image");

        String fileName = null;

        if(filePart != null && filePart.getSize() > 0){
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String path = getServletContext().getRealPath("/upload");
            filePart.write(path + File.separator + fileName);
        }

        TrainerReviewDTO dto = new TrainerReviewDTO();
        dto.setUserEmail(user.getEmail());
        dto.setTrainerId(trainerId);
        dto.setRating(rating);
        dto.setContent(content);
        dto.setImagePath(fileName);

        int result = service.writeReview(dto);

        resp.getWriter().write(result > 0 ? "리뷰 등록 성공" : "실패");
    }
}