package dto.member;

/**
 * ↔ NOTIFICATION 테이블
 * id, sendType(admin/gym/trainer/client), sendName, title, text,
 * sendId, recvId, is_read, create_date, notification_img
 */
public class NotificationDTO {

    private int    id;
    private String sendType;         // ENUM('admin','gym','trainer','client')
    private String sendName;
    private String title;
    private String text;             // DB: text (LONGTEXT)  ← 기존 message 필드 대체
    private String sendId;
    private String recvId;
    private boolean isRead;          // DB: is_read
    private String createDate;       // DB: create_date
    private String notificationImg;  // DB: notification_img

    // ── 이전 코드 호환용 필드 ────────────────────────────────────
    private String email;    // recvId 별칭 (이전 코드 호환)
    private String type;     // sendType 별칭 (이전 코드 호환)
    private String message;  // text 별칭 (이전 코드 호환)
    private String url;      // 화면 이동 URL (선택)
    private String createdAt;

    public NotificationDTO() {}

    public NotificationDTO(int id, String sendType, String sendName, String title,
                           String text, String sendId, String recvId,
                           boolean isRead, String createDate, String notificationImg) {
        this.id              = id;
        this.sendType        = sendType;
        this.sendName        = sendName;
        this.title           = title;
        this.text            = text;
        this.sendId          = sendId;
        this.recvId          = recvId;
        this.isRead          = isRead;
        this.createDate      = createDate;
        this.notificationImg = notificationImg;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSendType() { return sendType; }
    public void setSendType(String sendType) { this.sendType = sendType; this.type = sendType; }

    public String getSendName() { return sendName; }
    public void setSendName(String sendName) { this.sendName = sendName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getText() { return text; }
    public void setText(String text) { this.text = text; this.message = text; }

    public String getSendId() { return sendId; }
    public void setSendId(String sendId) { this.sendId = sendId; }

    public String getRecvId() { return recvId; }
    public void setRecvId(String recvId) { this.recvId = recvId; this.email = recvId; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean isRead) { this.isRead = isRead; }

    public String getCreateDate() { return createDate; }
    public void setCreateDate(String createDate) { this.createDate = createDate; this.createdAt = createDate; }

    public String getNotificationImg() { return notificationImg; }
    public void setNotificationImg(String notificationImg) { this.notificationImg = notificationImg; }

    // 호환용
    public String getEmail() { return recvId; }
    public void setEmail(String email) { this.email = email; this.recvId = email; }

    public String getType() { return sendType; }
    public void setType(String type) { this.type = type; this.sendType = type; }

    public String getMessage() { return text; }
    public void setMessage(String message) { this.message = message; this.text = message; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getCreatedAt() { return createDate; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; this.createDate = createdAt; }
}
