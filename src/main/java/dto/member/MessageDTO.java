package dto.member;

import java.sql.Timestamp;

public class MessageDTO {
    private int id;
    private String sender;
    private String receiver;
    private String content;
    private Timestamp sendTime;
    private int isRead;
    
	public MessageDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MessageDTO(int id, String sender, String receiver, String content, Timestamp sendTime, int isRead) {
		super();
		this.id = id;
		this.sender = sender;
		this.receiver = receiver;
		this.content = content;
		this.sendTime = sendTime;
		this.isRead = isRead;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public int getIsRead() {
		return isRead;
	}

	public void setIsRead(int isRead) {
		this.isRead = isRead;
	}
    
}