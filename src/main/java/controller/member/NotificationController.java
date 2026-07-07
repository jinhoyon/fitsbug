package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dto.common.NotificationDTO;
import dto.common.UserDTO;
import service.member.NotificationService;
import service.member.NotificationServiceImpl;

@WebServlet("/member/notification")
public class NotificationController extends HttpServlet {

    private final NotificationService notificationService = new NotificationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        UserDTO user = (UserDTO) req.getSession().getAttribute("loginUser");
        if (user == null) {
            out.print("{\"error\":\"login required\"}");
            return;
        }

        String action = req.getParameter("action");
        String recvId = user.getEmail();

        if ("readAll".equals(action)) {
            notificationService.readAll(recvId);
            out.print("{\"result\":\"ok\"}");
            return;
        }

        if ("readOne".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            notificationService.readOne(id);
        }

        List<NotificationDTO> list = notificationService.getList(recvId);
        int count = notificationService.getUnreadCount(recvId);

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
            if (i != list.size() - 1) {
                json.append(",");
            }
        }
        json.append("]}");
        out.print(json.toString());
    }

    private String escape(String s) {
        return s == null ? "" : s.replace("\"", "\\\"");
    }
}
