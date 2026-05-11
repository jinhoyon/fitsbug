package dao.member;

import java.util.List;
import dto.member.ChatRoomDTO;
import dto.member.ChatMessageDTO;

public interface ChatDAO {
    // 채팅방 조회 (없으면 null)
    ChatRoomDTO findRoom(int userId1, int userId2);
    // 채팅방 생성 → 생성된 id 반환
    int insertRoom(int userId1, int userId2);
    // 메시지 전송
    void insertMessage(int roomId, int senderId, String message);
    // 메시지 목록 조회
    List<ChatMessageDTO> findMessagesByRoomId(int roomId);
    // 읽음 처리
    void markAllRead(int roomId, int userId);
}
