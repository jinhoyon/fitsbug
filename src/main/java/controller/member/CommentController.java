package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.CommentDTO;
import dto.common.UserDTO;
import service.member.CommentService;
import service.member.CommentServiceImpl;

@WebServlet("/member/comment")
public class CommentController extends HttpServlet {

    private CommentService service = new CommentServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session   = req.getSession(false);
        UserDTO     loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;

        if (loginUser == null) {
            resp.getWriter().write("{\"result\":\"notLogin\"}");
            return;
        }

        int    postNum = Integer.parseInt(req.getParameter("postNum"));
        String userId  = loginUser.getEmail(); 
        String body    = req.getParameter("body");

        if (body == null || body.trim().isEmpty()) {
            resp.getWriter().write("{\"result\":\"empty\"}");
            return;
        }

        CommentDTO dto = new CommentDTO();
        dto.setPostNum(postNum);
        dto.setUserId(userId);
        dto.setBody(body.trim());

        service.write(dto);

        resp.getWriter().write("{\"result\":\"ok\"}");
    }
}
