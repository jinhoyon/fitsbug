package dto.member;

/**
 * ↔ INBODY_LOG 테이블
 * id, member_id, record_date, weight, muscle_mass, body_fat, img
 *
 * 변경: email → memberId (FK 기준)
 *       muscle → muscleMass (DB: muscle_mass)
 *       fat → bodyFat (DB: body_fat)
 *       imagePath → img (DB: img)
 */
public class InbodyLogDTO {

    private int    id;
    private int    memberId;    // member_id (FK → MEMBER.id)
    private String recordDate;  // record_date (DATE)
    private double weight;
    private double muscleMass;  // DB: muscle_mass
    private double bodyFat;     // DB: body_fat
    private String img;         // DB: img

    // ── 화면 표시용 (JOIN용) ─────────────────────────────────────
    private String email;       // USER.email (JOIN용)

    public InbodyLogDTO() {}

    public InbodyLogDTO(int id, int memberId, String recordDate,
                        double weight, double muscleMass, double bodyFat, String img) {
        this.id         = id;
        this.memberId   = memberId;
        this.recordDate = recordDate;
        this.weight     = weight;
        this.muscleMass = muscleMass;
        this.bodyFat    = bodyFat;
        this.img        = img;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public String getRecordDate() { return recordDate; }
    public void setRecordDate(String recordDate) { this.recordDate = recordDate; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public double getMuscleMass() { return muscleMass; }
    public void setMuscleMass(double muscleMass) { this.muscleMass = muscleMass; }

    public double getBodyFat() { return bodyFat; }
    public void setBodyFat(double bodyFat) { this.bodyFat = bodyFat; }

    public String getImg() { return img; }
    public void setImg(String img) { this.img = img; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
