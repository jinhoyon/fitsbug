package dto.member;

public class MealLogDTO {

    private int    id;
    private int    memberId;       // member_id (FK → MEMBER.id)
    private String mealDate;       // meal_date (DATE)
    private String meal;           // 식단 내용 전체 텍스트 (LONGTEXT)
    private String description;    // DB: derscription (LONGTEXT) — DB 오타 그대로 유지
    private int    totCalorie;     // totcalorie (INTEGER)
    private String mealTime;       // meal_time (TIME)
    private int    calories;       // calories (INTEGER)
    private int    protein;        // protein (INTEGER)
    private int    carbs;          // carbs (INTEGER)
    private int    fat;            // fat (INTEGER)
    private String imageUrl;       // image_url (VARCHAR(255))

    public MealLogDTO() {}

    public MealLogDTO(int id, int memberId, String mealDate, String meal, int totCalorie) {
        this.id         = id;
        this.memberId   = memberId;
        this.mealDate   = mealDate;
        this.meal       = meal;
        this.totCalorie = totCalorie;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public String getMealDate() { return mealDate; }
    public void setMealDate(String mealDate) { this.mealDate = mealDate; }

    public String getMeal() { return meal; }
    public void setMeal(String meal) { this.meal = meal; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getTotCalorie() { return totCalorie; }
    public void setTotCalorie(int totCalorie) { this.totCalorie = totCalorie; }

    public String getMealTime() { return mealTime; }
    public void setMealTime(String mealTime) { this.mealTime = mealTime; }

    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }

    public int getProtein() { return protein; }
    public void setProtein(int protein) { this.protein = protein; }

    public int getCarbs() { return carbs; }
    public void setCarbs(int carbs) { this.carbs = carbs; }

    public int getFat() { return fat; }
    public void setFat(int fat) { this.fat = fat; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

}
