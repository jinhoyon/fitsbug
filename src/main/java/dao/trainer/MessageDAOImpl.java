package dao.trainer;

import dto.member.ChatMessageDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MessageDAOImpl implements MessageDAO {

    @Override
    public List<Map<String, Object>> getRoomList(SqlSession session, int userId) {
        return session.selectList("mapper.trainer.message.getRoomList", userId);
    }

    @Override
    public List<ChatMessageDTO> getChatMessages(SqlSession session, int roomId) {
        return session.selectList("mapper.trainer.message.getChatMessages", roomId);
    }

    @Override
    public void markRoomAsRead(SqlSession session, int roomId, int userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("roomId", roomId);
        params.put("myId", userId);
        session.update("mapper.trainer.message.markAsRead", params);
    }

    @Override
    public int getUnreadCount(SqlSession session, int userId) {
        return session.selectOne("mapper.trainer.message.getUnreadCount", userId);
    }

    @Override
    public Integer findRoom(SqlSession session, int userOne, int userTwo) {
        Map<String, Object> params = new HashMap<>();
        params.put("userOne", userOne);
        params.put("userTwo", userTwo);
        return session.selectOne("mapper.trainer.message.findRoom", params);
    }

    @Override
    public void createRoom(SqlSession session, int userOne, int userTwo) {
        Map<String, Object> params = new HashMap<>();
        params.put("userOne", userOne);
        params.put("userTwo", userTwo);
        session.insert("mapper.trainer.message.createRoom", params);
    }

    @Override
    public void sendMessage(SqlSession session, ChatMessageDTO message) {
        session.insert("mapper.trainer.message.sendMessage", message);
    }
}
