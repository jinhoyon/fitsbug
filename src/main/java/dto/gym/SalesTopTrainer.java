package dto.gym;

import java.math.BigDecimal;

public class SalesTopTrainer {
	private int trainerId;
    private String trainerName;
    private String profileImg;
    private BigDecimal totalSales;
    private int sessionCount;
	public SalesTopTrainer() {
		super();
	}
	public SalesTopTrainer(int trainerId, String trainerName, String profileImg, BigDecimal totalSales,
			int sessionCount) {
		super();
		this.trainerId = trainerId;
		this.trainerName = trainerName;
		this.profileImg = profileImg;
		this.totalSales = totalSales;
		this.sessionCount = sessionCount;
	}
	public int getTrainerId() {
		return trainerId;
	}
	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
	}
	public String getTrainerName() {
		return trainerName;
	}
	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public BigDecimal getTotalSales() {
		return totalSales;
	}
	public void setTotalSales(BigDecimal totalSales) {
		this.totalSales = totalSales;
	}
	public int getSessionCount() {
		return sessionCount;
	}
	public void setSessionCount(int sessionCount) {
		this.sessionCount = sessionCount;
	}
	@Override
	public String toString() {
		return "SalesTopTrainer [trainerId=" + trainerId + ", trainerName=" + trainerName + ", profileImg=" + profileImg
				+ ", totalSales=" + totalSales + ", sessionCount=" + sessionCount + "]";
	}
	
    
}
