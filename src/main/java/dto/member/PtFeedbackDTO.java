package dto.member;

import java.time.LocalDateTime;

public class PtFeedbackDTO {
    private int id;
    private String userEmail;
    private String trainerName;
    private String content;
    private LocalDateTime sessionDate;

    private String exercise;
    private String food;    
    private String inbody;

    private String feedback;
    private String growth;
    private String nextPlan;
    
	public PtFeedbackDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PtFeedbackDTO(int id, String userEmail, String trainerName, String content, LocalDateTime sessionDate,
			String exercise, String food, String inbody, String feedback, String growth, String nextPlan) {
		super();
		this.id = id;
		this.userEmail = userEmail;
		this.trainerName = trainerName;
		this.content = content;
		this.sessionDate = sessionDate;
		this.exercise = exercise;
		this.food = food;
		this.inbody = inbody;
		this.feedback = feedback;
		this.growth = growth;
		this.nextPlan = nextPlan;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getTrainerName() {
		return trainerName;
	}

	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getSessionDate() {
		return sessionDate;
	}

	public void setSessionDate(LocalDateTime sessionDate) {
		this.sessionDate = sessionDate;
	}

	public String getExercise() {
		return exercise;
	}

	public void setExercise(String exercise) {
		this.exercise = exercise;
	}

	public String getFood() {
		return food;
	}

	public void setFood(String food) {
		this.food = food;
	}

	public String getInbody() {
		return inbody;
	}

	public void setInbody(String inbody) {
		this.inbody = inbody;
	}

	public String getFeedback() {
		return feedback;
	}

	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	public String getGrowth() {
		return growth;
	}

	public void setGrowth(String growth) {
		this.growth = growth;
	}

	public String getNextPlan() {
		return nextPlan;
	}

	public void setNextPlan(String nextPlan) {
		this.nextPlan = nextPlan;
	}

}