package dto.gym;

public class WeeklyVisitStat {
	private String dayName;      // MON, TUE ...
    private int visitCount;      // 방문 수
    private int heightPercent;// 그래프 높이 (%)
    private String dateLabel;
    
	public WeeklyVisitStat() {
		super();
	}
	public WeeklyVisitStat(String dayName, int visitCount, int heightPercent, String dateLabel) {
		super();
		this.dayName = dayName;
		this.visitCount = visitCount;
		this.heightPercent = heightPercent;
		this.dateLabel = dateLabel;
	}
	public String getDayName() {
		return dayName;
	}
	public void setDayName(String dayName) {
		this.dayName = dayName;
	}
	public int getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}
	public int getHeightPercent() {
		return heightPercent;
	}
	public void setHeightPercent(int heightPercent) {
		this.heightPercent = heightPercent;
	}
	public String getDateLabel() {
		return dateLabel;
	}
	public void setDateLabel(String dateLabel) {
		this.dateLabel = dateLabel;
	}
    
}
