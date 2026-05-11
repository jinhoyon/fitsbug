package dto.trainer;

public class MealDTO {

    private int id;
    private int userId;

    private String mealType;
    private String mealName;
    private String mealTime;
    private String imageUrl;

    private int calories;
    private int protein;
    private int carbs;
    private int fat;
    private int totcalorie;

    private String mealDate;

    public MealDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getMealType() { return mealType; }
    public void setMealType(String mealType) { this.mealType = mealType; }

    public String getMealName() { return mealName; }
    public void setMealName(String mealName) { this.mealName = mealName; }

    public String getMealTime() { return mealTime; }
    public void setMealTime(String mealTime) { this.mealTime = mealTime; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }

    public int getProtein() { return protein; }
    public void setProtein(int protein) { this.protein = protein; }

    public int getCarbs() { return carbs; }
    public void setCarbs(int carbs) { this.carbs = carbs; }

    public int getFat() { return fat; }
    public void setFat(int fat) { this.fat = fat; }

    public int getTotcalorie() { return totcalorie; }
    public void setTotcalorie(int totcalorie) { this.totcalorie = totcalorie; }

    public String getMealDate() { return mealDate; }
    public void setMealDate(String mealDate) { this.mealDate = mealDate; }
}
