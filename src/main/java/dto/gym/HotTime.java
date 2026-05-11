package dto.gym;

public class HotTime {
	private String dayName;
    private int hour;
    private int visitCount;
    private int heightPercent;

    public HotTime() {
        super();
    }

    public HotTime(String dayName, int hour, int visitCount, int heightPercent) {
        super();
        this.dayName = dayName;
        this.hour = hour;
        this.visitCount = visitCount;
        this.heightPercent = heightPercent;
    }

    public String getDayName() {
        return dayName;
    }

    public void setDayName(String dayName) {
        this.dayName = dayName;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
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

	@Override
	public String toString() {
		return "HotTime [dayName=" + dayName + ", hour=" + hour + ", visitCount=" + visitCount + ", heightPercent="
				+ heightPercent + "]";
	}
    
}
