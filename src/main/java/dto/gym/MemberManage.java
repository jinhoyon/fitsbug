package dto.gym;

public class MemberManage {
	private int memberId;
	private String memberName;
	private String tel;
	private int membershipNum;
	private String membershipType;
	private int typeRep;
	private String startDate;
	private String endDate;
	private String status;
	private int usedPtCount;
	private int remainPtCount;
	private int remainDays;
	private String memberSource;

	public MemberManage() {
		super();
	}

	public MemberManage(int memberId, String memberName, String tel, int membershipNum, String membershipType,
			int typeRep, String startDate, String endDate, String status, int usedPtCount, int remainPtCount,
			int remainDays, String memberSource) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.tel = tel;
		this.membershipNum = membershipNum;
		this.membershipType = membershipType;
		this.typeRep = typeRep;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
		this.usedPtCount = usedPtCount;
		this.remainPtCount = remainPtCount;
		this.remainDays = remainDays;
		this.memberSource = memberSource;
	}

	public int getMemberId() {
		return memberId;
	}

	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getMembershipNum() {
		return membershipNum;
	}

	public void setMembershipNum(int membershipNum) {
		this.membershipNum = membershipNum;
	}

	public String getMembershipType() {
		return membershipType;
	}

	public void setMembershipType(String membershipType) {
		this.membershipType = membershipType;
	}

	public int getTypeRep() {
		return typeRep;
	}

	public void setTypeRep(int typeRep) {
		this.typeRep = typeRep;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getUsedPtCount() {
		return usedPtCount;
	}

	public void setUsedPtCount(int usedPtCount) {
		this.usedPtCount = usedPtCount;
	}

	public int getRemainPtCount() {
		return remainPtCount;
	}

	public void setRemainPtCount(int remainPtCount) {
		this.remainPtCount = remainPtCount;
	}

	public int getRemainDays() {
		return remainDays;
	}

	public void setRemainDays(int remainDays) {
		this.remainDays = remainDays;
	}

	public String getMemberSource() {
		return memberSource;
	}

	public void setMemberSource(String memberSource) {
		this.memberSource = memberSource;
	}

	@Override
	public String toString() {
		return "MemberManage [memberId=" + memberId + ", memberName=" + memberName + ", tel=" + tel + ", membershipNum="
				+ membershipNum + ", membershipType=" + membershipType + ", typeRep=" + typeRep + ", startDate="
				+ startDate + ", endDate=" + endDate + ", status=" + status + ", usedPtCount=" + usedPtCount
				+ ", remainPtCount=" + remainPtCount + ", remainDays=" + remainDays + ", memberSource=" + memberSource
				+ "]";
	}

}
