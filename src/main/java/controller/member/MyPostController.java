package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.MyPostDTO;

@WebServlet("/member/mypost")
public class MyPostController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔥 테스트 데이터
        MyPostDTO post = new MyPostDTO();
        post.setTitle("오늘 운동 완료!");
        post.setContent("가슴 + 삼두 루틴 완료 💪");
        post.setImage(""); // 이미지 없으면 ""
        post.setLikeCount(24);
        post.setCommentCount(5);

        req.setAttribute("myPost", post);

        req.getRequestDispatcher("/member/main.jsp").forward(req, resp);
	}
}