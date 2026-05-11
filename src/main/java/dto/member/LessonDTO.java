package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ LESSON 테이블 (DB SQL 기준으로 수정)
 * DB 실제 컬럼:
 *   id, trainer_id, client_id, start_time, end_time,
 *   status(예약완료/완료/취소), notes, lesson_date, created_at
 *
 * 수정: goal 필드 제거 (DB LESSON 테이블에 없음)
 */
public class LessonDTO {

    private int    id;
    private int    trainerId;    // trainer_id (FK → TRAINER.id)
    private int    clientId;     // client_id  (FK → MEMBER.id)
    private String startTime;    // start_time (TIME → String)
    private String endTime;      // end_time
    private String status;       // ENUM('예약완료','완료','취소') DEFAULT '예약완료'
    private String notes;        // notes (LONGTEXT)
    private String lessonDate;   // lesson_date (VARCHAR(50))
    private LocalDateTime createdAt;

    // ── JOIN용 ────────────────────────────────────────────────
    private String trainerName;
    private String clientName;
    private String clientNickname;

    public LessonDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }

    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getLessonDate() { return lessonDate; }
    public void setLessonDate(String lessonDate) { this.lessonDate = lessonDate; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }

    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }

    public String getClientNickname() { return clientNickname; }
    public void setClientNickname(String clientNickname) { this.clientNickname = clientNickname; }

    /** goal 필드 호환용 getter (기존 코드 참조 시 notes 반환) */
    public String getGoal() { return notes; }
    public void setGoal(String goal) { this.notes = goal; }
}
