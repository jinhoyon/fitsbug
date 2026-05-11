package dto.gym;

import java.math.BigDecimal;

public class TopTrainerRevenue {
	 private String trainerName;   // 트레이너 이름
	 private int sessionCount;     // 세션 수
	 private BigDecimal revenue;   // 매출
	 private Integer trainerId;
	public TopTrainerRevenue() {
		super();
	}
	public TopTrainerRevenue(String trainerName, int sessionCount, BigDecimal revenue, Integer trainerId) {
		super();
		this.trainerName = trainerName;
		this.sessionCount = sessionCount;
		this.revenue = revenue;
		this.trainerId = trainerId;
	}
	public String getTrainerName() {
		return trainerName;
	}
	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}
	public int getSessionCount() {
		return sessionCount;
	}
	public void setSessionCount(int sessionCount) {
		this.sessionCount = sessionCount;
	}
	public BigDecimal getRevenue() {
		return revenue;
	}
	public void setRevenue(BigDecimal revenue) {
		this.revenue = revenue;
	}
	public Integer getTrainerId() {
		return trainerId;
	}
	public void setTrainerId(Integer trainerId) {
		this.trainerId = trainerId;
	}
	@Override
	public String toString() {
		return "TopTrainerRevenue [trainerName=" + trainerName + ", sessionCount=" + sessionCount + ", revenue="
				+ revenue + ", trainerId=" + trainerId + "]";
	}
	
	 
	 
}
