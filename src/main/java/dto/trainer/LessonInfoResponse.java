package dto.trainer;

public class LessonInfoResponse {
    private int lessonId;
    private String goal;
    private String memberName;
    private String startTime;
    private String endTime;
    private int durationMinutes;
    private String status;
    private int lessonCount;

    // constructor
    public LessonInfoResponse(LessonDTO lesson, ClientDTO client) {
        this.lessonId = lesson.getLessonId();
        this.goal = lesson.getGoal();
        this.memberName = lesson.getMemberName();
        this.startTime = lesson.getStartTime();
        this.endTime = lesson.getEndTime();
        this.durationMinutes = lesson.getDurationMinutes();
        this.status = lesson.getStatus();
        this.lessonCount = client != null ? client.getLessonCount() : 0;
    }

    public int getLessonId() {
        return lessonId;
    }

    public String getGoal() {
        return goal;
    }

    public String getMemberName() {
        return memberName;
    }

    public String getStartTime() {
        return startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public String getStatus() {
        return status;
    }

    public int getLessonCount() {
        return lessonCount;
    }
}