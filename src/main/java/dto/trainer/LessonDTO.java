package dto.trainer;

public class LessonDTO {
    private int lessonId;
    private String goal;
    private String memberName;
    private String startTime;
    private String endTime;
    private int durationMinutes;
    private String status;
    private int clientId;
    private String lessonDate; // "YYYY-MM-DD"
    private int topPx;         // pixel offset from top of 24h grid (1h = 80px)
    private int heightPx;      // pixel height based on duration


    public LessonDTO() {
    }

    public LessonDTO(int lessonId, String goal, String memberName, String startTime, String endTime, int durationMinutes, String status, int clientId) {
        this.lessonId = lessonId;
        this.goal = goal;
        this.memberName = memberName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.durationMinutes = durationMinutes;
        this.status = status;
        this.clientId = clientId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
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

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public String getLessonDate() { return lessonDate; }
    public void setLessonDate(String lessonDate) { this.lessonDate = lessonDate; }

    public int getTopPx() { return topPx; }
    public void setTopPx(int topPx) { this.topPx = topPx; }

    public int getHeightPx() { return heightPx; }
    public void setHeightPx(int heightPx) { this.heightPx = heightPx; }
}
