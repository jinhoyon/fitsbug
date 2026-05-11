package dto.gym;

import java.time.LocalTime;

public class TodayPtSchedule {
	private LocalTime startTime; // "14:00"
	private String trainerName; // 트레이너 이름
	private String memberName; // 회원 이름
	private String membershipName; // "3개월 이용권"
	private String status; // 예약완료 / 완료 / 취소

	public TodayPtSchedule() {
		super();
	}

	public TodayPtSchedule(LocalTime startTime, String trainerName, String memberName, String membershipName,
			String status) {
		super();
		this.startTime = startTime;
		this.trainerName = trainerName;
		this.memberName = memberName;
		this.membershipName = membershipName;
		this.status = status;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
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

	public String getMembershipName() {
		return membershipName;
	}

	public void setMembershipName(String membershipName) {
		this.membershipName = membershipName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "TodayPtSchedule [startTime=" + startTime + ", trainerName=" + trainerName + ", memberName=" + memberName
				+ ", membershipName=" + membershipName + ", status=" + status + "]";
	}

	

}
