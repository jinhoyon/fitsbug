package dto.member;

/**
 * ↔ CHAT_MESSAGE 테이블 (신규)
 * id, room_id, sender_id, message, is_read, send_date
 */
public class ChatMessageDTO {

    private int    id;
    private int    roomId;      // room_id (FK → CHAT_ROOM.id)
    private int    senderId;   // sender_id (FK → USER.id)
    private String message;
    private int    isRead;     // is_read TINYINT DEFAULT 0
    private String sendDate;   // send_date

    // 화면 표시용
    private String senderNickname;
    private String senderProfileImg;

    public ChatMessageDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public int getIsRead() { return isRead; }
    public void setIsRead(int isRead) { this.isRead = isRead; }

    public String getSendDate() { return sendDate; }
    public void setSendDate(String sendDate) { this.sendDate = sendDate; }

    public String getSenderNickname() { return senderNickname; }
    public void setSenderNickname(String senderNickname) { this.senderNickname = senderNickname; }

    public String getSenderProfileImg() { return senderProfileImg; }
    public void setSenderProfileImg(String senderProfileImg) { this.senderProfileImg = senderProfileImg; }
}
