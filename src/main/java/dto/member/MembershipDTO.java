package dto.member;

/**
 * ↔ MEMBERSHIP 테이블 (신규)
 * id, gym_id, trainer_id, type(day/month/pt), type_rep, price
 */
public class MembershipDTO {

    private int    id;
    private Integer gymId;
    private Integer trainerId;
    private String type;       // ENUM('day','month','pt')
    private int    typeRep;   // type_rep (개월 수 또는 횟수)
    private double price;

    // 화면용
    private String gymName;
    private String trainerName;
    private String label;       // 화면 표시용 이름 (예: "3개월 이용권")

    public MembershipDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public Integer getTrainerId() { return trainerId; }
    public void setTrainerId(Integer trainerId) { this.trainerId = trainerId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public int getTypeRep() { return typeRep; }
    public void setTypeRep(int typeRep) { this.typeRep = typeRep; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getGymName() { return gymName; }
    public void setGymName(String gymName) { this.gymName = gymName; }

    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
}
