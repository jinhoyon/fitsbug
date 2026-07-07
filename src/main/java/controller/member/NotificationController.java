package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.member.NotificationDAO;
import dao.member.NotificationDAOImpl;
import dto.common.NotificationDTO;
import dto.common.UserDTO;

@WebServlet("/member/notification")
public class NotificationController extends HttpServlet {

    private NotificationDAO dao = new NotificationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        UserDTO user = (UserDTO) req.getSession().getAttribute("loginUser");
        if (user == null) { out.print("{\"error\":\"login required\"}"); return; }

        String action = req.getParameter("action");
        String recvId = user.getEmail();               // NOTIFICATION.recvId = USER.email

        // 전체 읽음 처리
        if ("readAll".equals(action)) {
            dao.updateReadAll(recvId);
            out.print("{\"result\":\"ok\"}");
            return;
        }

        // 개별 읽음 처리
        if ("readOne".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.updateReadOne(id);
        }

        // 알림 목록 + 미읽음 수
        List<NotificationDTO> list = dao.findByRecvId(recvId);
        int count = dao.countUnread(recvId);

        StringBuilder json = new StringBuilder();
        json.append("{\"count\":").append(count).append(",\"list\":[");

        for (int i = 0; i < list.size(); i++) {
            NotificationDTO n = list.get(i);
            json.append("{")
                .append("\"id\":").append(n.getId()).append(",")
                .append("\"sendType\":\"").append(escape(n.getSendType())).append("\",")
                .append("\"sendName\":\"").append(escape(n.getSendName())).append("\",")
                .append("\"title\":\"").append(escape(n.getTitle())).append("\",")
                .append("\"text\":\"").append(escape(n.getText())).append("\",")
                .append("\"isRead\":").append(n.isRead()).append(",")
                .append("\"createDate\":\"").append(escape(n.getCreateDate())).append("\"")
                .append("}");
            if (i != list.size() - 1) json.append(",");
        }
        json.append("]}");
        out.print(json.toString());
    }

    private String escape(String s) { return s == null ? "" : s.replace("\"", "\\\""); }
}
