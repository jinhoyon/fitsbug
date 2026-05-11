package dto.gym;

import java.time.LocalTime;

public class Schedule {
	private int gsNum;
	private int gymNum;
	private LocalTime availableWeekdayStart;
	private LocalTime availableWeekdayEnd;
	private LocalTime availableWeekendStart;
	private LocalTime availableWeekendEnd;
	
	public Schedule() {
		super();
	}

	public Schedule(int gsNum, int gymNum, LocalTime availableWeekdayStart, LocalTime availableWeekdayEnd,
			LocalTime availableWeekendStart, LocalTime availableWeekendEnd) {
		super();
		this.gsNum = gsNum;
		this.gymNum = gymNum;
		this.availableWeekdayStart = availableWeekdayStart;
		this.availableWeekdayEnd = availableWeekdayEnd;
		this.availableWeekendStart = availableWeekendStart;
		this.availableWeekendEnd = availableWeekendEnd;
	}

	public int getGsNum() {
		return gsNum;
	}

	public void setGsNum(int gsNum) {
		this.gsNum = gsNum;
	}

	public int getGymNum() {
		return gymNum;
	}

	public void setGymNum(int gymNum) {
		this.gymNum = gymNum;
	}

	public LocalTime getAvailableWeekdayStart() {
		return availableWeekdayStart;
	}

	public void setAvailableWeekdayStart(LocalTime availableWeekdayStart) {
		this.availableWeekdayStart = availableWeekdayStart;
	}

	public LocalTime getAvailableWeekdayEnd() {
		return availableWeekdayEnd;
	}

	public void setAvailableWeekdayEnd(LocalTime availableWeekdayEnd) {
		this.availableWeekdayEnd = availableWeekdayEnd;
	}

	public LocalTime getAvailableWeekendStart() {
		return availableWeekendStart;
	}

	public void setAvailableWeekendStart(LocalTime availableWeekendStart) {
		this.availableWeekendStart = availableWeekendStart;
	}

	public LocalTime getAvailableWeekendEnd() {
		return availableWeekendEnd;
	}

	public void setAvailableWeekendEnd(LocalTime availableWeekendEnd) {
		this.availableWeekendEnd = availableWeekendEnd;
	}

	@Override
	public String toString() {
		return "Schedule [gsNum=" + gsNum + ", gymNum=" + gymNum + ", availableWeekdayStart=" + availableWeekdayStart
				+ ", availableWeekdayEnd=" + availableWeekdayEnd + ", availableWeekendStart=" + availableWeekendStart
				+ ", availableWeekendEnd=" + availableWeekendEnd + "]";
	}

	
	
	
	
	
}
