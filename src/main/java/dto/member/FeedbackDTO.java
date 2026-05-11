package dto.member;

/**
 * ↔ FEEDBACK 테이블
 * id, workout_id, meal_id, inbody_id, feedback_date,
 * summary, comment, next_comment, trainer_id
 *
 * 변경: 기존 단순 4필드 → 전체 테이블 컬럼 완전 매핑
 */
public class FeedbackDTO {

    private int    id;
    private Integer workoutId;    // workout_id (FK → WORKOUT_LOG.id, nullable)
    private Integer mealId;       // meal_id    (FK → MEAL_LOG.id, nullable)
    private Integer inbodyId;     // inbody_id  (FK → INBODY_LOG.id, nullable)
    private String feedbackDate;  // feedback_date (DATE)
    private String summary;       // LONGTEXT
    private String comment;       // LONGTEXT
    private String nextComment;   // next_comment (LONGTEXT)
    private Integer trainerId;    // trainer_id (FK → TRAINER.id)

    // ── 화면 표시용 (JOIN용) ─────────────────────────────────────
    private String trainerName;   // TRAINER 조인용
    private String date;          // feedback_date 문자열 표시용

    public FeedbackDTO() {}

    public FeedbackDTO(int id, Integer workoutId, Integer mealId, Integer inbodyId,
                       String feedbackDate, String summary, String comment,
                       String nextComment, Integer trainerId) {
        this.id           = id;
        this.workoutId    = workoutId;
        this.mealId       = mealId;
        this.inbodyId     = inbodyId;
        this.feedbackDate = feedbackDate;
        this.summary      = summary;
        this.comment      = comment;
        this.nextComment  = nextComment;
        this.trainerId    = trainerId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getWorkoutId() { return workoutId; }
    public void setWorkoutId(Integer workoutId) { this.workoutId = workoutId; }

    public Integer getMealId() { return mealId; }
    public void setMealId(Integer mealId) { this.mealId = mealId; }

    public Integer getInbodyId() { return inbodyId; }
    public void setInbodyId(Integer inbodyId) { this.inbodyId = inbodyId; }

    public String getFeedbackDate() { return feedbackDate; }
    public void setFeedbackDate(String feedbackDate) { this.feedbackDate = feedbackDate; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getNextComment() { return nextComment; }
    public void setNextComment(String nextComment) { this.nextComment = nextComment; }

    public Integer getTrainerId() { return trainerId; }
    public void setTrainerId(Integer trainerId) { this.trainerId = trainerId; }

    // 화면용
    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }

    public String getDate() { return date != null ? date : feedbackDate; }
    public void setDate(String date) { this.date = date; }

    // 이전 content 필드와의 호환성
    public String getContent() { return comment; }
}
