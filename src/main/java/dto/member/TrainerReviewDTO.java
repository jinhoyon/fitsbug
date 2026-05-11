package dto.member;

public class TrainerReviewDTO {
    private String userEmail;
    private int trainerId;
    private int rating;
    private String content;
    private String imagePath;
    private String createdAt;
    
	public TrainerReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TrainerReviewDTO(String userEmail, int trainerId, int rating, String content, String imagePath,
			String createdAt) {
		super();
		this.userEmail = userEmail;
		this.trainerId = trainerId;
		this.rating = rating;
		this.content = content;
		this.imagePath = imagePath;
		this.createdAt = createdAt;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public int getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

}