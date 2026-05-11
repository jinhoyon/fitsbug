package dto.gym;

import java.util.Date;

public class GymNotice {
	private int id;
	private int gymId;
	private String title;
	private String content;
	private int viewCount;
	private Date createdAt;
	
	public GymNotice() {
		super();
	}

	public GymNotice(int id, int gymId, String title, String content, int viewCount, Date createdAt) {
		super();
		this.id = id;
		this.gymId = gymId;
		this.title = title;
		this.content = content;
		this.viewCount = viewCount;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getGymId() {
		return gymId;
	}

	public void setGymId(int gymId) {
		this.gymId = gymId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "GymNotice [id=" + id + ", gymId=" + gymId + ", title=" + title + ", content=" + content + ", viewCount="
				+ viewCount + ", createdAt=" + createdAt + "]";
	}

	
	
	
}
