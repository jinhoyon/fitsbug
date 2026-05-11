package dto.member;

import java.sql.Timestamp;

public class CommentDTO {
	private int id;
    private int postNum;
    private String userId;
    private String body;
    private Timestamp createdAt;
    
	public CommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CommentDTO(int id, int postNum, String userId, String body, Timestamp createdAt) {
		super();
		this.id = id;
		this.postNum = postNum;
		this.userId = userId;
		this.body = body;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
    
}