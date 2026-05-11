package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.ChatMessageDTO;
import dto.member.ChatRoomDTO;
import dto.member.UserDTO;
import service.member.ChatService;
import service.member.ChatServiceImpl;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

/**
 * /member/chat         — GET: chat.jsp 포워드 (trainerId 파라미터로 채팅방 생성/조회)
 * /member/chat/message — GET: 메시지 목록 JSON, POST: 메시지 전송
 */
@WebServlet({"/member/chat", "/member/chat/message"})
public class ChatController extends HttpServlet {

    private ChatService service = new ChatServiceImpl();

    // ── GET ─────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String uri = req.getRequestURI();

        // ── /member/chat/message → 메시지 목록 JSON ─────────────
        if (uri.endsWith("/message")) {
            resp.setContentType("application/json;charset=UTF-8");
            int roomId = parseIntOrZero(req.getParameter("roomId"));
            if (roomId == 0) { resp.getWriter().write("[]"); return; }

            // 읽음 처리 + 목록 조회를 service에서 한번에
            List<ChatMessageDTO> list = service.getMessages(roomId, loginUser.getId());
            resp.getWriter().write(toMessagesJson(list, loginUser.getId()));
            return;
        }

        // ── /member/chat → chat.jsp 포워드 ──────────────────────
        // trainerId 파라미터로 상대방 USER.id를 조회해 채팅방 생성 or 재사용
        String trainerIdStr = req.getParameter("trainerId");
        if (trainerIdStr == null || trainerIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/member/main");
            return;
        }

        int trainerId = parseIntOrZero(trainerIdStr);

        // TRAINER.id → USER.id 변환
        int trainerUserId = getTrainerUserId(trainerId);
        if (trainerUserId == 0) {
            resp.sendRedirect(req.getContextPath() + "/member/main");
            return;
        }

        int myUserId = loginUser.getId();

        // 기존 채팅방 조회 또는 신규 생성
        ChatRoomDTO room = service.getOrCreateRoom(myUserId, trainerUserId);
        int roomId = room.getId();

        // 트레이너 닉네임 조회
        String trainerNickname = getTrainerNickname(trainerUserId);

        req.setAttribute("roomId",           roomId);
        req.setAttribute("trainerUserId",    trainerUserId);
        req.setAttribute("trainerNickname",  trainerNickname);
        req.getRequestDispatcher("/member/chat.jsp").forward(req, resp);
    }

    // ── POST: 메시지 전송 ─────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.getWriter().write("{\"result\":\"notLogin\"}");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int roomId  = parseIntOrZero(req.getParameter("roomId"));
        String msg  = req.getParameter("message");

        if (roomId == 0 || msg == null || msg.trim().isEmpty()) {
            resp.getWriter().write("{\"result\":\"error\"}");
            return;
        }

        service.sendMessage(roomId, loginUser.getId(), msg.trim());
        resp.getWriter().write("{\"result\":\"ok\"}");
    }

    // ── 헬퍼: TRAINER.id → USER.id ────────────────────────────────
    private int getTrainerUserId(int trainerId) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Integer userId = sql.selectOne("mapper.TrainerMapper.findUserIdById", trainerId);
            return userId != null ? userId : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ── 헬퍼: USER.id → nickname ──────────────────────────────────
    private String getTrainerNickname(int userId) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            String nickname = sql.selectOne("mapper.UserMapper.findNicknameById", userId);
            return nickname != null ? nickname : "트레이너";
        } catch (Exception e) {
            return "트레이너";
        }
    }

    // ── 헬퍼: 메시지 목록 → JSON ──────────────────────────────────
    private String toMessagesJson(List<ChatMessageDTO> list, int myUserId) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            ChatMessageDTO m = list.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"id\":").append(m.getId()).append(",")
                .append("\"senderId\":").append(m.getSenderId()).append(",")
                .append("\"isMe\":").append(m.getSenderId() == myUserId).append(",")
                .append("\"content\":\"").append(esc(m.getMessage())).append("\",")
                .append("\"createdAt\":\"").append(nvl(m.getSendDate())).append("\",")
                .append("\"nickname\":\"").append(esc(m.getSenderNickname())).append("\"")
                .append("}");
        }
        json.append("]");
        return json.toString();
    }

    private int    parseIntOrZero(String s) {
        try { return s != null ? Integer.parseInt(s.trim()) : 0; } catch (Exception e) { return 0; }
    }
    private String nvl(String s) { return s == null ? "" : s; }
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
