package dto.gym;

import java.time.LocalDateTime;

public class NoticeImages {
	private int imageId;
	private int noticeId;
	private String imageUrl;
	private int orderIndex;
	private LocalDateTime createdAt;
	
	public NoticeImages() {
		super();
	}

	public NoticeImages(int imageId, int noticeId, String imageUrl, int orderIndex, LocalDateTime createdAt) {
		super();
		this.imageId = imageId;
		this.noticeId = noticeId;
		this.imageUrl = imageUrl;
		this.orderIndex = orderIndex;
		this.createdAt = createdAt;
	}

	public int getImageId() {
		return imageId;
	}

	public void setImageId(int imageId) {
		this.imageId = imageId;
	}

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "NoticeImages [imageId=" + imageId + ", noticeId=" + noticeId + ", imageUrl=" + imageUrl
				+ ", orderIndex=" + orderIndex + ", createdAt=" + createdAt + "]";
	}
	
	
	
	
}
