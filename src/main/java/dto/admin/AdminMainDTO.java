package dto.admin;

public class AdminMainDTO {
	// 상단 및 요약 지표 전용
    private long totMember;         // 총 회원 수
    private long newMember;         // 신규 가입
    private long totPartners;       // 등록 지점/트레이너
    private long salesAmount;       // 총 매출액
    private long authWaitCount;     // 자격 승인 대기
    private long reportWaitCount;   // 신고 미처리
    private long inquiryWaitCount;  // 문의 미처리
    private long settleWaitCount;   // 정산 대기
    
	public AdminMainDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AdminMainDTO(long totMember, long newMember, long totPartners, long salesAmount, long authWaitCount,
			long reportWaitCount, long inquiryWaitCount, long settleWaitCount) {
		super();
		this.totMember = totMember;
		this.newMember = newMember;
		this.totPartners = totPartners;
		this.salesAmount = salesAmount;
		this.authWaitCount = authWaitCount;
		this.reportWaitCount = reportWaitCount;
		this.inquiryWaitCount = inquiryWaitCount;
		this.settleWaitCount = settleWaitCount;
	}

	public long getTotMember() {
		return totMember;
	}

	public void setTotMember(long totMember) {
		this.totMember = totMember;
	}

	public long getNewMember() {
		return newMember;
	}

	public void setNewMember(long newMember) {
		this.newMember = newMember;
	}

	public long getTotPartners() {
		return totPartners;
	}

	public void setTotPartners(long totPartners) {
		this.totPartners = totPartners;
	}

	public long getSalesAmount() {
		return salesAmount;
	}

	public void setSalesAmount(long salesAmount) {
		this.salesAmount = salesAmount;
	}

	public long getAuthWaitCount() {
		return authWaitCount;
	}

	public void setAuthWaitCount(long authWaitCount) {
		this.authWaitCount = authWaitCount;
	}

	public long getReportWaitCount() {
		return reportWaitCount;
	}

	public void setReportWaitCount(long reportWaitCount) {
		this.reportWaitCount = reportWaitCount;
	}

	public long getInquiryWaitCount() {
		return inquiryWaitCount;
	}

	public void setInquiryWaitCount(long inquiryWaitCount) {
		this.inquiryWaitCount = inquiryWaitCount;
	}

	public long getSettleWaitCount() {
		return settleWaitCount;
	}

	public void setSettleWaitCount(long settleWaitCount) {
		this.settleWaitCount = settleWaitCount;
	}

	@Override
	public String toString() {
		return "AdminMainDTO [totMember=" + totMember + ", newMember=" + newMember + ", totPartners=" + totPartners
				+ ", salesAmount=" + salesAmount + ", authWaitCount=" + authWaitCount + ", reportWaitCount="
				+ reportWaitCount + ", inquiryWaitCount=" + inquiryWaitCount + ", settleWaitCount=" + settleWaitCount
				+ "]";
	}
}