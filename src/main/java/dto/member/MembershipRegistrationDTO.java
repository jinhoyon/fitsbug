package dto.member;

/**
 * ↔ MEMBERSHIP_PT 테이블 (DB SQL 기준으로 수정)
 * 기존: MEMBERSHIP_REGISTRATION 테이블 참조 → 실제 DB는 MEMBERSHIP_PT
 *
 * DB 실제 컬럼:
 *   id, member_id, membership_id, gym_id,
 *   register_date, start_date, end_date,
 *   status(active/expired), trainer_id,
 *   next_session, lesson_count, last_session
 */
public class MembershipRegistrationDTO {

    private int    id;
    private int    memberId;       // member_id (FK → MEMBER.id)
    private int    membershipId;   // membership_id (FK → MEMBERSHIP.id)
    private Integer gymId;         // gym_id (FK → GYM.id)
    private String registerDate;   // register_date (DATE)
    private String startDate;      // start_date (DATE)
    private String endDate;        // end_date (DATE)
    private String status;         // ENUM('active','expired')
    private Integer trainerId;     // trainer_id (FK → TRAINER.id)
    private String nextSession;    // next_session (VARCHAR(100))
    private int    lessonCount;    // lesson_count (INTEGER DEFAULT 0)
    private String lastSession;    // last_session (VARCHAR(100))

    // 화면용 (JOIN용)
    private String memberName;
    private String membershipLabel;
    private String trainerName;
    private String gymName;

    public MembershipRegistrationDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public int getMembershipId() { return membershipId; }
    public void setMembershipId(int membershipId) { this.membershipId = membershipId; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public String getRegisterDate() { return registerDate; }
    public void setRegisterDate(String registerDate) { this.registerDate = registerDate; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getTrainerId() { return trainerId; }
    public void setTrainerId(Integer trainerId) { this.trainerId = trainerId; }

    public String getNextSession() { return nextSession; }
    public void setNextSession(String nextSession) { this.nextSession = nextSession; }

    public int getLessonCount() { return lessonCount; }
    public void setLessonCount(int lessonCount) { this.lessonCount = lessonCount; }

    public String getLastSession() { return lastSession; }
    public void setLastSession(String lastSession) { this.lastSession = lastSession; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public String getMembershipLabel() { return membershipLabel; }
    public void setMembershipLabel(String membershipLabel) { this.membershipLabel = membershipLabel; }

    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }

    public String getGymName() { return gymName; }
    public void setGymName(String gymName) { this.gymName = gymName; }
}
