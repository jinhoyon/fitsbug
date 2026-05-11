package dto.gym;

public class MembershipDistribution {
	private int month;
    private int percent;
	public MembershipDistribution() {
		super();
	}
	public MembershipDistribution(int month, int percent) {
		super();
		this.month = month;
		this.percent = percent;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getPercent() {
		return percent;
	}
	public void setPercent(int percent) {
		this.percent = percent;
	}
	@Override
	public String toString() {
		return "MembershipDistribution [month=" + month + ", percent=" + percent + "]";
	}
    
}
