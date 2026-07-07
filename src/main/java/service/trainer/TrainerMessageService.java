package service.trainer;

import dao.trainer.MessageDAO;
import dao.trainer.MessageDAOImpl;
import dto.member.ChatMessageDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.List;
import java.util.Map;

public interface TrainerMessageService {

    MessagesPageData loadPage(int myId, String roomIdStr);

    int sendMessage(int myId, int partnerId, String messageText);

    class MessagesPageData {
        public final List<Map<String, Object>> rooms;
        public final List<ChatMessageDTO> messages;
        public final Integer currentRoomId;
        public final String partnerNickname;
        public final String partnerProfileImg;
        public final Integer partnerId;
        public final int unreadCount;

        public MessagesPageData(List<Map<String, Object>> rooms,
                                List<ChatMessageDTO> messages,
                                Integer currentRoomId,
                                String partnerNickname,
                                String partnerProfileImg,
                                Integer partnerId,
                                int unreadCount) {
            this.rooms = rooms;
            this.messages = messages;
            this.currentRoomId = currentRoomId;
            this.partnerNickname = partnerNickname;
            this.partnerProfileImg = partnerProfileImg;
            this.partnerId = partnerId;
            this.unreadCount = unreadCount;
        }
    }
}
