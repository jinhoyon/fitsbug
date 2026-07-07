package dto.common;

import java.time.LocalDateTime;

/**
 * Shared LESSON table DTO used across member scheduling and trainer calendar modules.
 */
public class LessonDTO {

    private int id;
    private int trainerId;
    private int clientId;
    private String startTime;
    private String endTime;
    private String status;
    private String notes;
    private String lessonDate;
    private LocalDateTime createdAt;

    // JOIN / display fields
    private String trainerName;
    private String clientName;
    private String clientNickname;
    private String memberName;
    private int durationMinutes;
    private int topPx;
    private int heightPx;

    public LessonDTO() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLessonId() {
        return id;
    }

    public void setLessonId(int lessonId) {
        this.id = lessonId;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getGoal() {
        return notes;
    }

    public void setGoal(String goal) {
        this.notes = goal;
    }

    public String getLessonDate() {
        return lessonDate;
    }

    public void setLessonDate(String lessonDate) {
        this.lessonDate = lessonDate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getTrainerName() {
        return trainerName;
    }

    public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public String getClientNickname() {
        return clientNickname;
    }

    public void setClientNickname(String clientNickname) {
        this.clientNickname = clientNickname;
    }

    public String getMemberName() {
        return memberName != null ? memberName : clientNickname;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public int getTopPx() {
        return topPx;
    }

    public void setTopPx(int topPx) {
        this.topPx = topPx;
    }

    public int getHeightPx() {
        return heightPx;
    }

    public void setHeightPx(int heightPx) {
        this.heightPx = heightPx;
    }
}
