package dto.gym;

public class ScheduleDay {
	private int value;
    private String name;
    private String dateText;
	public ScheduleDay() {
		super();
	}
	public ScheduleDay(int value, String name, String dateText) {
		super();
		this.value = value;
		this.name = name;
		this.dateText = dateText;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDateText() {
		return dateText;
	}
	public void setDateText(String dateText) {
		this.dateText = dateText;
	}
	@Override
	public String toString() {
		return "ScheduleDay [value=" + value + ", name=" + name + ", dateText=" + dateText + "]";
	}
    
}	
