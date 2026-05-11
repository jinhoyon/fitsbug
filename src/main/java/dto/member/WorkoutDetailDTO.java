package dto.member;

public class WorkoutDetailDTO {

    private int id;
    private int workoutId; // FK

    private String title;
    private int set;
    private int rep;
    private double weight;

    public WorkoutDetailDTO() {}

    // getter/setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getWorkoutId() { return workoutId; }
    public void setWorkoutId(int workoutId) { this.workoutId = workoutId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getSet() { return set; }
    public void setSet(int set) { this.set = set; }

    public int getRep() { return rep; }
    public void setRep(int rep) { this.rep = rep; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }
}