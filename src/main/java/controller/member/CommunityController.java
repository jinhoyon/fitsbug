package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.member.CompleteDAO;
import dao.member.CompleteDAOImpl;
import dto.member.PostDTO;
import dto.common.UserDTO;
import service.member.PostService;
import service.member.PostServiceImpl;

@WebServlet("/member/community")
public class CommunityController extends HttpServlet {

    private PostService postService = new PostServiceImpl();
    private CompleteDAO completeDAO = new CompleteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session   = request.getSession();
        UserDTO     loginUser = (UserDTO) session.getAttribute("loginUser");

        List<PostDTO> postList = postService.getPosts();
        request.setAttribute("postList", postList);

        if (loginUser != null) {
            String email = loginUser.getEmail();
            request.setAttribute("weekLog", completeDAO.getWeekLog(email));
            request.setAttribute("streak",  completeDAO.getStreak(email));
            request.setAttribute("best",    completeDAO.getBestStreak(email));
        }

        request.getRequestDispatcher("/member/community.jsp").forward(request, response);
    }
}
