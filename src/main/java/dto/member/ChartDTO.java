package dto.member;

public class ChartDTO {
	private String date;

    // ===== 공통 =====
    private double value; // workout

    // ===== 식단 =====
    private String food;
    private double calorie;

    // ===== 인바디 =====
    private double weight;
    private double muscle;
    private double fat;
    
	public ChartDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChartDTO(String date, double value, String food, double calorie, double weight, double muscle, double fat) {
		super();
		this.date = date;
		this.value = value;
		this.food = food;
		this.calorie = calorie;
		this.weight = weight;
		this.muscle = muscle;
		this.fat = fat;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public String getFood() {
		return food;
	}

	public void setFood(String food) {
		this.food = food;
	}

	public double getCalorie() {
		return calorie;
	}

	public void setCalorie(double calorie) {
		this.calorie = calorie;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getMuscle() {
		return muscle;
	}

	public void setMuscle(double muscle) {
		this.muscle = muscle;
	}

	public double getFat() {
		return fat;
	}

	public void setFat(double fat) {
		this.fat = fat;
	}
    
}