package dto.gym;

import java.sql.Timestamp;
import java.util.Date;

public class Review {
	@Override
	public String toString() {
		return "Review [reviewNum=" + reviewNum + ", gymId=" + gymId + ", clientId=" + clientId + ", clientName="
				+ clientName + ", rating=" + rating + ", comment=" + comment + ", createdAt=" + createdAt + ", file="
				+ file + "]";
	}

	private int reviewNum;
	private int gymId;
	private int clientId;
	private String clientName;
	private Double rating;
	private String comment;
	private Timestamp createdAt;
	private String file;
	
	public Review() {
		super();
	}

	public Review(int reviewNum, int gymId, int clientId, String clientName, Double rating, String comment,
			Timestamp createdAt, String file) {
		super();
		this.reviewNum = reviewNum;
		this.gymId = gymId;
		this.clientId = clientId;
		this.clientName = clientName;
		this.rating = rating;
		this.comment = comment;
		this.createdAt = createdAt;
		this.file = file;
	}

	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public int getGymId() {
		return gymId;
	}

	public void setGymId(int gymId) {
		this.gymId = gymId;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	


	
	
}
