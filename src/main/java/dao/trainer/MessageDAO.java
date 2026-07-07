package dao.trainer;

import dto.member.ChatMessageDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public interface MessageDAO {
    List<Map<String, Object>> getRoomList(SqlSession session, int userId);

    List<ChatMessageDTO> getChatMessages(SqlSession session, int roomId);

    void markRoomAsRead(SqlSession session, int roomId, int userId);

    int getUnreadCount(SqlSession session, int userId);

    Integer findRoom(SqlSession session, int userOne, int userTwo);

    void createRoom(SqlSession session, int userOne, int userTwo);

    void sendMessage(SqlSession session, ChatMessageDTO message);
}
