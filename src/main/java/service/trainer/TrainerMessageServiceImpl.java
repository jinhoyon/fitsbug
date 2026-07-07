package service.trainer;

import dao.trainer.MessageDAO;
import dao.trainer.MessageDAOImpl;
import dto.member.ChatMessageDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class TrainerMessageServiceImpl implements TrainerMessageService {

    private final MessageDAO messageDAO = new MessageDAOImpl();

    @Override
    public MessagesPageData loadPage(int myId, String roomIdStr) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            List<Map<String, Object>> rooms = messageDAO.getRoomList(session, myId);
            List<ChatMessageDTO> messages = Collections.emptyList();
            Integer currentRoomId = null;
            String partnerNickname = null;
            String partnerProfileImg = null;
            Integer partnerId = null;

            if (roomIdStr != null) {
                int roomId = Integer.parseInt(roomIdStr);
                messages = messageDAO.getChatMessages(session, roomId);
                currentRoomId = roomId;
                messageDAO.markRoomAsRead(session, roomId, myId);
                session.commit();

                if (rooms != null) {
                    for (Map<String, Object> room : rooms) {
                        Object rid = room.get("roomId");
                        if (rid != null && Integer.parseInt(rid.toString()) == roomId) {
                            partnerNickname = (String) room.get("partnerNickname");
                            partnerProfileImg = (String) room.get("partnerProfileImg");
                            Object pid = room.get("partnerId");
                            if (pid != null) {
                                partnerId = Integer.parseInt(pid.toString());
                            }
                            break;
                        }
                    }
                }
            }

            int unreadCount = messageDAO.getUnreadCount(session, myId);
            return new MessagesPageData(rooms, messages, currentRoomId,
                    partnerNickname, partnerProfileImg, partnerId, unreadCount);
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public int sendMessage(int myId, int partnerId, String messageText) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            Integer roomId = messageDAO.findRoom(session, myId, partnerId);
            if (roomId == null) {
                messageDAO.createRoom(session, myId, partnerId);
                session.commit();
                roomId = messageDAO.findRoom(session, myId, partnerId);
            }

            ChatMessageDTO msg = new ChatMessageDTO();
            msg.setRoomId(roomId);
            msg.setSenderId(myId);
            msg.setMessage(messageText.trim());
            messageDAO.sendMessage(session, msg);
            session.commit();
            return roomId;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
