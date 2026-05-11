package dto.gym;

import java.sql.Date;

public class MembershipRegistration {
	private Integer mrNum;
	private Integer memberNum;
    private Integer membershipNum;
    private Date registerDate;
    private Date startDate;
    private Date endDate;
    private String status;
    private Integer gymId;
    private Integer trainerId;
    private String nextSession;
    private Integer lessonCount;
    private String lastSession;
	
	public MembershipRegistration(Integer mrNum, Integer memberNum, Integer membershipNum, Date registerDate,
			Date startDate, Date endDate, String status, Integer gymId, Integer trainerId, String nextSession,
			Integer lessonCount, String lastSession) {
		super();
		this.mrNum = mrNum;
		this.memberNum = memberNum;
		this.membershipNum = membershipNum;
		this.registerDate = registerDate;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.gymId = gymId;
		this.trainerId = trainerId;
		this.nextSession = nextSession;
		this.lessonCount = lessonCount;
		this.lastSession = lastSession;
	}
	public MembershipRegistration() {
		super();
	}
	public Integer getMrNum() {
		return mrNum;
	}
	public void setMrNum(Integer mrNum) {
		this.mrNum = mrNum;
	}
	public Integer getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(Integer memberNum) {
		this.memberNum = memberNum;
	}
	public Integer getMembershipNum() {
		return membershipNum;
	}
	public void setMembershipNum(Integer membershipNum) {
		this.membershipNum = membershipNum;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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
	public Integer getTrainerId() {
		return trainerId;
	}
	public void setTrainerId(Integer trainerId) {
		this.trainerId = trainerId;
	}
	public String getNextSession() {
		return nextSession;
	}
	public void setNextSession(String nextSession) {
		this.nextSession = nextSession;
	}
	public Integer getLessonCount() {
		return lessonCount;
	}
	public void setLessonCount(Integer lessonCount) {
		this.lessonCount = lessonCount;
	}
	public String getLastSession() {
		return lastSession;
	}
	public void setLastSession(String lastSession) {
		this.lastSession = lastSession;
	}
	@Override
	public String toString() {
		return "MembershipRegistration [mrNum=" + mrNum + ", memberNum=" + memberNum + ", membershipNum="
				+ membershipNum + ", registerDate=" + registerDate + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", status=" + status + ", gymId=" + gymId + ", trainerId=" + trainerId + ", nextSession="
				+ nextSession + ", lessonCount=" + lessonCount + ", lastSession=" + lastSession + "]";
	}
	
	
}
