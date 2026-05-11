package dto.member;

/**
 * ↔ TRAINER_SPECIALIZATION 테이블 (신규)
 * id, trainer_id, TYPE (LONGTEXT)
 */
public class TrainerSpecializationDTO {

    private int    id;
    private int    trainerId;  // trainer_id (FK → TRAINER.id)
    private String type;       // DB: TYPE (전문 분야 텍스트)

    public TrainerSpecializationDTO() {}

    public TrainerSpecializationDTO(int id, int trainerId, String type) {
        this.id        = id;
        this.trainerId = trainerId;
        this.type      = type;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}
