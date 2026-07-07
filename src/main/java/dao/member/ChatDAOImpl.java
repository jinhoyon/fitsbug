package dao.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.member.ChatMessageDTO;
import dto.member.ChatRoomDTO;
import util.MybatisSqlSessionFactory;

public class ChatDAOImpl implements ChatDAO {

    private static final String NS = "mapper.member.chat.";

    @Override
    public ChatRoomDTO findRoom(int userId1, int userId2) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        ChatRoomDTO room = null;
        try {
            Map<String, Integer> param = new HashMap<>();
            param.put("userId1", userId1);
            param.put("userId2", userId2);
            room = session.selectOne(NS + "findRoom", param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return room;
    }

    @Override
    public int insertRoom(int userId1, int userId2) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int id = 0;
        try {
            ChatRoomDTO room = new ChatRoomDTO();
            room.setUserOne(userId1);
            room.setUserTwo(userId2);
            session.insert(NS + "insertRoom", room);
            session.commit();
            id = room.getId(); // useGeneratedKeys로 채워짐
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return id;
    }

    @Override
    public void insertMessage(int roomId, int senderId, String message) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            ChatMessageDTO msg = new ChatMessageDTO();
            msg.setRoomId(roomId);
            msg.setSenderId(senderId);
            msg.setMessage(message);
            session.insert(NS + "insertMessage", msg);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public List<ChatMessageDTO> findMessagesByRoomId(int roomId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<ChatMessageDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findMessagesByRoomId", roomId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public void markAllRead(int roomId, int userId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            Map<String, Integer> param = new HashMap<>();
            param.put("roomId", roomId);
            param.put("userId", userId);
            session.update(NS + "markAllRead", param);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
