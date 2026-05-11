package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import service.member.PostReactionService;
import service.member.PostReactionServiceImpl;

@WebServlet("/member/reaction")
public class ReactionController extends HttpServlet {

    private PostReactionService service = new PostReactionServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        HttpSession session   = request.getSession(false);
        UserDTO     loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;


        if (loginUser == null) {
            response.getWriter().write("{\"result\":\"notLogin\"}");
            return;
        }

        String userId = loginUser.getEmail(); // PostReactionDTO.userId = String(email)
        int    postId = Integer.parseInt(request.getParameter("postNum"));
        String type   = request.getParameter("type");


        if (!type.equals("like") && !type.equals("good") && !type.equals("muscle")) {
            response.getWriter().write("{\"result\":\"invalidType\"}");
            return;
        }

        int result = service.addReaction(postId, userId, type);

        // result=0 이면 INSERT IGNORE 로 이미 누른 것 → duplicate
        if (result > 0) {
            response.getWriter().write("{\"result\":\"ok\"}");
        } else {
            response.getWriter().write("{\"result\":\"duplicate\"}");
        }
    }
}
