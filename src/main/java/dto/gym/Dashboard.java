package dto.gym;

import java.math.BigDecimal;
import java.util.List;

public class Dashboard {
	private int newMemberCount;

    private BigDecimal totalRevenue;
    private BigDecimal membershipRevenue;
    private BigDecimal ptRevenue;

    private List<TodayPtSchedule> todayScheduleList;
    private List<WeeklyVisitStat> weeklyVisitList;
    private List<TopTrainerRevenue> topTrainerList;

    private double newMemberGrowthRate;
    private double totalRevenueGrowthRate;
    private double membershipGrowthRate;
    private double ptGrowthRate;

    private String todayDate;
    private String weekStart;
    private String weekEnd;

    private List<MembershipDistribution> membershipDistributionList;
    private List<RevenueTrend> revenueTrendList;
    private List<HotTime> hotTimeList;
	public Dashboard() {
		super();
	}
	public Dashboard(int newMemberCount, BigDecimal totalRevenue, BigDecimal membershipRevenue, BigDecimal ptRevenue,
			List<TodayPtSchedule> todayScheduleList, List<WeeklyVisitStat> weeklyVisitList,
			List<TopTrainerRevenue> topTrainerList, double newMemberGrowthRate, double totalRevenueGrowthRate,
			double membershipGrowthRate, double ptGrowthRate, String todayDate, String weekStart, String weekEnd,
			List<MembershipDistribution> membershipDistributionList, List<RevenueTrend> revenueTrendList,
			List<HotTime> hotTimeList) {
		super();
		this.newMemberCount = newMemberCount;
		this.totalRevenue = totalRevenue;
		this.membershipRevenue = membershipRevenue;
		this.ptRevenue = ptRevenue;
		this.todayScheduleList = todayScheduleList;
		this.weeklyVisitList = weeklyVisitList;
		this.topTrainerList = topTrainerList;
		this.newMemberGrowthRate = newMemberGrowthRate;
		this.totalRevenueGrowthRate = totalRevenueGrowthRate;
		this.membershipGrowthRate = membershipGrowthRate;
		this.ptGrowthRate = ptGrowthRate;
		this.todayDate = todayDate;
		this.weekStart = weekStart;
		this.weekEnd = weekEnd;
		this.membershipDistributionList = membershipDistributionList;
		this.revenueTrendList = revenueTrendList;
		this.hotTimeList = hotTimeList;
	}
	public int getNewMemberCount() {
		return newMemberCount;
	}
	public void setNewMemberCount(int newMemberCount) {
		this.newMemberCount = newMemberCount;
	}
	public BigDecimal getTotalRevenue() {
		return totalRevenue;
	}
	public void setTotalRevenue(BigDecimal totalRevenue) {
		this.totalRevenue = totalRevenue;
	}
	public BigDecimal getMembershipRevenue() {
		return membershipRevenue;
	}
	public void setMembershipRevenue(BigDecimal membershipRevenue) {
		this.membershipRevenue = membershipRevenue;
	}
	public BigDecimal getPtRevenue() {
		return ptRevenue;
	}
	public void setPtRevenue(BigDecimal ptRevenue) {
		this.ptRevenue = ptRevenue;
	}
	public List<TodayPtSchedule> getTodayScheduleList() {
		return todayScheduleList;
	}
	public void setTodayScheduleList(List<TodayPtSchedule> todayScheduleList) {
		this.todayScheduleList = todayScheduleList;
	}
	public List<WeeklyVisitStat> getWeeklyVisitList() {
		return weeklyVisitList;
	}
	public void setWeeklyVisitList(List<WeeklyVisitStat> weeklyVisitList) {
		this.weeklyVisitList = weeklyVisitList;
	}
	public List<TopTrainerRevenue> getTopTrainerList() {
		return topTrainerList;
	}
	public void setTopTrainerList(List<TopTrainerRevenue> topTrainerList) {
		this.topTrainerList = topTrainerList;
	}
	public double getNewMemberGrowthRate() {
		return newMemberGrowthRate;
	}
	public void setNewMemberGrowthRate(double newMemberGrowthRate) {
		this.newMemberGrowthRate = newMemberGrowthRate;
	}
	public double getTotalRevenueGrowthRate() {
		return totalRevenueGrowthRate;
	}
	public void setTotalRevenueGrowthRate(double totalRevenueGrowthRate) {
		this.totalRevenueGrowthRate = totalRevenueGrowthRate;
	}
	public double getMembershipGrowthRate() {
		return membershipGrowthRate;
	}
	public void setMembershipGrowthRate(double membershipGrowthRate) {
		this.membershipGrowthRate = membershipGrowthRate;
	}
	public double getPtGrowthRate() {
		return ptGrowthRate;
	}
	public void setPtGrowthRate(double ptGrowthRate) {
		this.ptGrowthRate = ptGrowthRate;
	}
	public String getTodayDate() {
		return todayDate;
	}
	public void setTodayDate(String todayDate) {
		this.todayDate = todayDate;
	}
	public String getWeekStart() {
		return weekStart;
	}
	public void setWeekStart(String weekStart) {
		this.weekStart = weekStart;
	}
	public String getWeekEnd() {
		return weekEnd;
	}
	public void setWeekEnd(String weekEnd) {
		this.weekEnd = weekEnd;
	}
	public List<MembershipDistribution> getMembershipDistributionList() {
		return membershipDistributionList;
	}
	public void setMembershipDistributionList(List<MembershipDistribution> membershipDistributionList) {
		this.membershipDistributionList = membershipDistributionList;
	}
	public List<RevenueTrend> getRevenueTrendList() {
		return revenueTrendList;
	}
	public void setRevenueTrendList(List<RevenueTrend> revenueTrendList) {
		this.revenueTrendList = revenueTrendList;
	}
	public List<HotTime> getHotTimeList() {
		return hotTimeList;
	}
	public void setHotTimeList(List<HotTime> hotTimeList) {
		this.hotTimeList = hotTimeList;
	}
	@Override
	public String toString() {
		return "Dashboard [newMemberCount=" + newMemberCount + ", totalRevenue=" + totalRevenue + ", membershipRevenue="
				+ membershipRevenue + ", ptRevenue=" + ptRevenue + ", todayScheduleList=" + todayScheduleList
				+ ", weeklyVisitList=" + weeklyVisitList + ", topTrainerList=" + topTrainerList
				+ ", newMemberGrowthRate=" + newMemberGrowthRate + ", totalRevenueGrowthRate=" + totalRevenueGrowthRate
				+ ", membershipGrowthRate=" + membershipGrowthRate + ", ptGrowthRate=" + ptGrowthRate + ", todayDate="
				+ todayDate + ", weekStart=" + weekStart + ", weekEnd=" + weekEnd + ", membershipDistributionList="
				+ membershipDistributionList + ", revenueTrendList=" + revenueTrendList + ", hotTimeList=" + hotTimeList
				+ "]";
	}
	
	
    
    
}
