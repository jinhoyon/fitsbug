package dto.common;

/**
 * Shared NOTIFICATION DTO used across member inbox and trainer dashboard modules.
 */
public class NotificationDTO {

    private int id;
    private String sendType;
    private String sendName;
    private String title;
    private String text;
    private String sendId;
    private String recvId;
    private boolean read;
    private String createDate;
    private String notificationImg;

    // Trainer dashboard / legacy fields
    private String userId;
    private String memberName;
    private String targetUrl;
    private String createdAtLabel;
    private String createDateLabel;

    // Compatibility mirrors
    private String email;
    private String type;
    private String message;
    private String url;
    private String createdAt;

    public NotificationDTO() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNotificationId() {
        return id;
    }

    public void setNotificationId(int notificationId) {
        this.id = notificationId;
    }

    public String getSendType() {
        return sendType;
    }

    public void setSendType(String sendType) {
        this.sendType = sendType;
        this.type = sendType;
    }

    public String getSendName() {
        return sendName;
    }

    public void setSendName(String sendName) {
        this.sendName = sendName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
        this.message = text;
    }

    public String getSendId() {
        return sendId;
    }

    public void setSendId(String sendId) {
        this.sendId = sendId;
    }

    public String getRecvId() {
        return recvId;
    }

    public void setRecvId(String recvId) {
        this.recvId = recvId;
        this.email = recvId;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
        this.createdAt = createDate;
    }

    public String getNotificationImg() {
        return notificationImg;
    }

    public void setNotificationImg(String notificationImg) {
        this.notificationImg = notificationImg;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getTargetUrl() {
        return targetUrl;
    }

    public void setTargetUrl(String targetUrl) {
        this.targetUrl = targetUrl;
        this.url = targetUrl;
    }

    public String getCreatedAtLabel() {
        return createdAtLabel != null ? createdAtLabel : createDateLabel;
    }

    public void setCreatedAtLabel(String createdAtLabel) {
        this.createdAtLabel = createdAtLabel;
        this.createDateLabel = createdAtLabel;
    }

    public void setCreateDateLabel(String createDateLabel) {
        this.createDateLabel = createDateLabel;
        this.createdAtLabel = createDateLabel;
    }

    public String getEmail() {
        return recvId;
    }

    public void setEmail(String email) {
        this.email = email;
        this.recvId = email;
    }

    public String getType() {
        return sendType;
    }

    public void setType(String type) {
        this.type = type;
        this.sendType = type;
    }

    public String getMessage() {
        return text;
    }

    public void setMessage(String message) {
        this.message = message;
        this.text = message;
    }

    public String getUrl() {
        return targetUrl;
    }

    public void setUrl(String url) {
        this.url = url;
        this.targetUrl = url;
    }

    public String getCreatedAt() {
        return createDate;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
        this.createDate = createdAt;
    }
}
