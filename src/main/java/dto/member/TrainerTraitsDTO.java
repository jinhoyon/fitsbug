package dto.member;

/**
 * ↔ TRAINER_TRAITS 테이블 (신규)
 * id, trainer_id, TYPE (LONGTEXT)
 */
public class TrainerTraitsDTO {

    private int    id;
    private int    trainerId;
    private String type;      // DB: TYPE (트레이너 특성 텍스트)

    public TrainerTraitsDTO() {}

    public TrainerTraitsDTO(int id, int trainerId, String type) {
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
