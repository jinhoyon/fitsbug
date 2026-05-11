package dto.admin;

import java.util.Date;

public class ExerciseDTO {
	//exercise 테이블용
	private Integer egNum;
	private String type;
	private String difficulty;
	private String targetMuscle;
	
	//exercise_guide 테이블용
	private String title;
	private String description;
	private String keyPoint;
	private String image;
	private String video;
	private Date regDate;
	
	public ExerciseDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ExerciseDTO(Integer egNum, String type, String difficulty, String targetMuscle,
			String title, String description, String keyPoint, String image, String video, Date regDate) {
		super();
		this.egNum = egNum;
		this.type = type;
		this.difficulty = difficulty;
		this.targetMuscle = targetMuscle;
		this.title = title;
		this.description = description;
		this.keyPoint = keyPoint;
		this.image = image;
		this.video = video;
		this.regDate = regDate;
	}
	public Integer getEgNum() {
		return egNum;
	}

	public void setEgNum(Integer egNum) {
		this.egNum = egNum;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}

	public String getTargetMuscle() {
		return targetMuscle;
	}

	public void setTargetMuscle(String targetMuscle) {
		this.targetMuscle = targetMuscle;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeyPoint() {
		return keyPoint;
	}

	public void setKeyPoint(String keyPoint) {
		this.keyPoint = keyPoint;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}