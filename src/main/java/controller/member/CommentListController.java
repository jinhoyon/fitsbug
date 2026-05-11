package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.CommentDTO;
import service.member.CommentService;
import service.member.CommentServiceImpl;

@WebServlet("/member/commentList")
public class CommentListController extends HttpServlet {

    private CommentService service = new CommentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        int postNum = Integer.parseInt(req.getParameter("postNum"));
        List<CommentDTO> list = service.getComments(postNum);

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            CommentDTO c = list.get(i);
            json.append("{")
                .append("\"userId\":\"").append(escape(c.getUserId())).append("\",")
                .append("\"body\":\""  ).append(escape(c.getBody()  )).append("\"")
                .append("}");
            if (i < list.size() - 1) json.append(",");
        }
        json.append("]");

        resp.getWriter().write(json.toString());
    }

    // JSON 문자열 내 특수문자 이스케이프 (XSS/JSON 파괴 방지)
    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
