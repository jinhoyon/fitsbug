package dto.member;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class WorkoutLogDTO {

    private int id;

    private int memberId;
    private int sessionId;
    private int gymId;

    private LocalDate date;
    private LocalTime startTime;
    private LocalTime endTime;

    // 🔥 핵심 (1:N)
    private List<WorkoutDetailDTO> details;

    public WorkoutLogDTO() {}

    // getter/setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public int getSessionId() { return sessionId; }
    public void setSessionId(int sessionId) { this.sessionId = sessionId; }

    public int getGymId() { return gymId; }
    public void setGymId(int gymId) { this.gymId = gymId; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public LocalTime getStartTime() { return startTime; }
    public void setStartTime(LocalTime startTime) { this.startTime = startTime; }

    public LocalTime getEndTime() { return endTime; }
    public void setEndTime(LocalTime endTime) { this.endTime = endTime; }

    public List<WorkoutDetailDTO> getDetails() { return details; }
    public void setDetails(List<WorkoutDetailDTO> details) { this.details = details; }
}