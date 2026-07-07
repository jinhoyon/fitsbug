package controller.trainer;

import dto.member.ChatMessageDTO;
import dto.trainer.UserDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer/messages")
public class Messages extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int myId = loginUser.getId();

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            // Load all conversation rooms
            List<Map<String, Object>> rooms = sql.selectList("mapper.trainer.message.getRoomList", myId);
            request.setAttribute("rooms", rooms);

            // If a room is selected, load its messages
            String roomIdStr = request.getParameter("roomId");
            if (roomIdStr != null) {
                int roomId = Integer.parseInt(roomIdStr);

                List<ChatMessageDTO> messages = sql.selectList("mapper.trainer.message.getChatMessages", roomId);
                request.setAttribute("messages", messages);
                request.setAttribute("currentRoomId", roomId);

                // Mark partner messages as read
                Map<String, Object> readParams = new HashMap<>();
                readParams.put("roomId", roomId);
                readParams.put("myId",   myId);
                sql.update("mapper.trainer.message.markAsRead", readParams);
                sql.commit();

                // Find partner info from rooms list for the chat header
                if (rooms != null) {
                    for (Map<String, Object> room : rooms) {
                        Object rid = room.get("roomId");
                        if (rid != null && Integer.parseInt(rid.toString()) == roomId) {
                            request.setAttribute("partnerNickname",   room.get("partnerNickname"));
                            request.setAttribute("partnerProfileImg", room.get("partnerProfileImg"));
                            request.setAttribute("partnerId",         room.get("partnerId"));
                            break;
                        }
                    }
                }
            }

            // Unread count for nav badge
            int unread = sql.selectOne("mapper.trainer.message.getUnreadCount", myId);
            request.setAttribute("unreadCount", unread);
        }

        request.getRequestDispatcher("/trainer/messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int myId = loginUser.getId();

        String partnerIdStr = request.getParameter("partnerId");
        String messageText  = request.getParameter("message");
        String roomIdStr    = request.getParameter("roomId");

        if (partnerIdStr == null || messageText == null || messageText.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/trainer/messages"
                    + (roomIdStr != null ? "?roomId=" + roomIdStr : ""));
            return;
        }

        int partnerId = Integer.parseInt(partnerIdStr);
        messageText = messageText.trim();

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            // Find or create the room
            Map<String, Object> roomParams = new HashMap<>();
            roomParams.put("userOne", myId);
            roomParams.put("userTwo", partnerId);

            Integer roomId = sql.selectOne("mapper.trainer.message.findRoom", roomParams);
            if (roomId == null) {
                sql.insert("mapper.trainer.message.createRoom", roomParams);
                sql.commit();
                roomId = sql.selectOne("mapper.trainer.message.findRoom", roomParams);
            }

            // Insert message
            ChatMessageDTO msg = new ChatMessageDTO();
            msg.setRoomId(roomId);
            msg.setSenderId(myId);
            msg.setMessage(messageText);

            sql.insert("mapper.trainer.message.sendMessage", msg);
            sql.commit();

            response.sendRedirect(request.getContextPath() + "/trainer/messages?roomId=" + roomId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/trainer/messages"
                    + (roomIdStr != null ? "?roomId=" + roomIdStr : ""));
        }
    }
}
