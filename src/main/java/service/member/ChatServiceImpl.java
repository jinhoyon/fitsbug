package service.member;

import java.util.List;

import dao.member.ChatDAO;
import dao.member.ChatDAOImpl;
import dto.member.ChatMessageDTO;
import dto.member.ChatRoomDTO;

public class ChatServiceImpl implements ChatService {

    private ChatDAO dao = new ChatDAOImpl();

    /**
     * 두 유저 간 채팅방 조회.
     * 기존 채팅방이 있으면 반환, 없으면 새로 생성 후 반환.
     * ChatController에서 trainerId → userId 변환 후 이 메서드를 호출.
     */
    @Override
    public ChatRoomDTO getOrCreateRoom(int myUserId, int targetUserId) {
        // 1. 기존 채팅방 조회
        ChatRoomDTO room = dao.findRoom(myUserId, targetUserId);

        // 2. 없으면 신규 생성
        if (room == null) {
            int roomId = dao.insertRoom(myUserId, targetUserId);
            // 생성 직후 다시 조회해서 반환
            room = dao.findRoom(myUserId, targetUserId);
            // 혹시 조회 실패 시 임시 DTO 구성
            if (room == null) {
                room = new ChatRoomDTO();
                room.setId(roomId);
                room.setUserOne(myUserId);
                room.setUserTwo(targetUserId);
            }
        }
        return room;
    }

    /**
     * 메시지 목록 조회 + 상대방 메시지 읽음 처리
     */
    @Override
    public List<ChatMessageDTO> getMessages(int roomId, int myUserId) {
        // 읽음 처리 (내가 보낸 것 제외하고 모두 읽음으로)
        dao.markAllRead(roomId, myUserId);
        // 메시지 목록 반환
        return dao.findMessagesByRoomId(roomId);
    }

    /**
     * 메시지 전송
     * (알림 기능 제거 — 채팅 자체만 처리)
     */
    @Override
    public void sendMessage(int roomId, int senderId, String message) {
        dao.insertMessage(roomId, senderId, message);
    }
}
