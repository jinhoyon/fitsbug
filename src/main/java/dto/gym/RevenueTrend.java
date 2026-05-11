package dto.gym;

public class RevenueTrend {
	private int month;
    private int totalPercent;
    private int membershipPercent;
	public RevenueTrend() {
		super();
	}
	public RevenueTrend(int month, int totalPercent, int membershipPercent) {
		super();
		this.month = month;
		this.totalPercent = totalPercent;
		this.membershipPercent = membershipPercent;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getTotalPercent() {
		return totalPercent;
	}
	public void setTotalPercent(int totalPercent) {
		this.totalPercent = totalPercent;
	}
	public int getMembershipPercent() {
		return membershipPercent;
	}
	public void setMembershipPercent(int membershipPercent) {
		this.membershipPercent = membershipPercent;
	}
	@Override
	public String toString() {
		return "RevenueTrend [month=" + month + ", totalPercent=" + totalPercent + ", membershipPercent="
				+ membershipPercent + "]";
	}
	
    
}
