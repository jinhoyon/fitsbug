package dto.member;

public class MessageRoomDTO {
	private String email;        
    private String nickname;     
    private String lastMessage;  
    private int unreadCount;
    
	public MessageRoomDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MessageRoomDTO(String email, String nickname, String lastMessage, int unreadCount) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.lastMessage = lastMessage;
		this.unreadCount = unreadCount;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getLastMessage() {
		return lastMessage;
	}

	public void setLastMessage(String lastMessage) {
		this.lastMessage = lastMessage;
	}

	public int getUnreadCount() {
		return unreadCount;
	}

	public void setUnreadCount(int unreadCount) {
		this.unreadCount = unreadCount;
	}
    
}