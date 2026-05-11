package dto.member;

/**
 * ↔ trainer_availability 테이블 (신규)
 * id, trainer_id, day_of_week(MON/TUE/WED/THU/FRI/SAT/SUN),
 * start_time, end_time, is_active
 */
public class TrainerAvailabilityDTO {

    private int    id;
    private int    trainerId;   // trainer_id (FK)
    private String dayOfWeek;  // ENUM('MON','TUE','WED','THU','FRI','SAT','SUN')
    private String startTime;
    private String endTime;
    private boolean isActive;  // DEFAULT 1

    public TrainerAvailabilityDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getDayOfWeek() { return dayOfWeek; }
    public void setDayOfWeek(String dayOfWeek) { this.dayOfWeek = dayOfWeek; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
}
