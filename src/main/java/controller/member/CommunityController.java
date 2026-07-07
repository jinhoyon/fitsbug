package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.PostDTO;
import dto.common.UserDTO;
import service.member.PostService;
import service.member.PostServiceImpl;

@WebServlet("/member/community")
public class CommunityController extends HttpServlet {

    private final PostService postService = new PostServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session   = request.getSession();
        UserDTO     loginUser = (UserDTO) session.getAttribute("loginUser");

        List<PostDTO> postList = postService.getPosts();
        request.setAttribute("postList", postList);

        if (loginUser != null) {
            String email = loginUser.getEmail();
            request.setAttribute("weekLog", postService.getWeekLog(email));
            request.setAttribute("streak", postService.getStreak(email));
            request.setAttribute("best", postService.getBestStreak(email));
        }

        request.getRequestDispatcher("/member/community.jsp").forward(request, response);
    }
}
