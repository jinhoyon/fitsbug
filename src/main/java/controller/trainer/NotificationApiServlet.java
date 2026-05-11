package controller.trainer;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.trainer.NotificationDAOImpl;
import dao.trainer.NotificationDAO;
import dto.trainer.NotificationDTO;

public class NotificationApiServlet extends HttpServlet {
    private final NotificationDAO notificationDAO = new NotificationDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = resolveUserId(request);
        String memberName = request.getParameter("memberName");
        int limit = parsePositiveInt(request.getParameter("limit"), 20);
        List<NotificationDTO> notifications = notificationDAO.findRecentByUserAndMember(userId, memberName, limit, LocalDate.now());

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\":true,");
        json.append("\"notifications\":[");

        for (int i = 0; i < notifications.size(); i++) {
            NotificationDTO n = notifications.get(i);
            if (i > 0) {
                json.append(',');
            }
            json.append('{')
                    .append("\"notificationId\":").append(n.getNotificationId()).append(',')
                    .append("\"memberName\":\"").append(escapeJson(n.getMemberName())).append("\",")
                    .append("\"type\":\"").append(escapeJson(n.getType())).append("\",")
                    .append("\"title\":\"").append(escapeJson(n.getTitle())).append("\",")
                    .append("\"message\":\"").append(escapeJson(n.getMessage())).append("\",")
                    .append("\"targetUrl\":\"").append(escapeJson(n.getTargetUrl())).append("\",")
                    .append("\"isRead\":").append(n.isRead()).append(',')
                    .append("\"createdAtLabel\":\"").append(escapeJson(n.getCreatedAtLabel())).append("\"")
                    .append('}');
        }

        json.append("]}");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = resolveUserId(request);
        String memberName = request.getParameter("memberName");
        String path = request.getPathInfo();
        int updated = 0;

        if ("/read".equals(path)) {
            int notificationId = parsePositiveInt(request.getParameter("notificationId"), 0);
            updated = notificationDAO.markAsRead(notificationId, userId);
        } else if ("/read-all".equals(path)) {
            updated = notificationDAO.markAllAsRead(userId, memberName);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"success\":true,\"updated\":" + updated + "}");
    }

    private String resolveUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object id = session.getAttribute("id");
            if (id != null && !String.valueOf(id).trim().isEmpty()) {
                return String.valueOf(id).trim();
            }
        }
        return "demo-user";
    }

    private int parsePositiveInt(String raw, int fallback) {
        try {
            int value = Integer.parseInt(raw);
            return value > 0 ? value : fallback;
        } catch (Exception e) {
            return fallback;
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
