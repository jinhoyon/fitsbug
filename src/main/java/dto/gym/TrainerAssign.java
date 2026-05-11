package dto.gym;

import java.sql.Timestamp;

public class TrainerAssign {
	private String trainerName;
	private String memberName;
	private Timestamp assignedAt;
	private String membershipName;
	private int remainingCount;
	private String status;
	private Integer gymId;

	public TrainerAssign() {
		super();
	}

	public TrainerAssign(String trainerName, String memberName, Timestamp assignedAt, String membershipName,
			int remainingCount, String status, Integer gymId) {
		super();
		this.trainerName = trainerName;
		this.memberName = memberName;
		this.assignedAt = assignedAt;
		this.membershipName = membershipName;
		this.remainingCount = remainingCount;
		this.status = status;
		this.gymId = gymId;
	}

	public String getTrainerName() {
		return trainerName;
	}

	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Timestamp getAssignedAt() {
		return assignedAt;
	}

	public void setAssignedAt(Timestamp assignedAt) {
		this.assignedAt = assignedAt;
	}

	public String getMembershipName() {
		return membershipName;
	}

	public void setMembershipName(String membershipName) {
		this.membershipName = membershipName;
	}

	public int getRemainingCount() {
		return remainingCount;
	}

	public void setRemainingCount(int remainingCount) {
		this.remainingCount = remainingCount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getGymId() {
		return gymId;
	}

	public void setGymId(Integer gymId) {
		this.gymId = gymId;
	}

	@Override
	public String toString() {
		return "TrainerAssign [trainerName=" + trainerName + ", memberName=" + memberName + ", assignedAt=" + assignedAt
				+ ", membershipName=" + membershipName + ", remainingCount=" + remainingCount + ", status=" + status
				+ ", gymId=" + gymId + "]";
	}

}
