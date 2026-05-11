package service.member;

import java.util.List;
import dto.member.ChatRoomDTO;
import dto.member.ChatMessageDTO;

public interface ChatService {

    /**
     * 두 유저 간 채팅방 조회. 없으면 null 반환.
     */
    ChatRoomDTO getOrCreateRoom(int myUserId, int targetUserId);

    /**
     * 채팅방 메시지 목록 조회 + 읽음 처리
     */
    List<ChatMessageDTO> getMessages(int roomId, int myUserId);

    /**
     * 메시지 전송
     */
    void sendMessage(int roomId, int senderId, String message);
}
