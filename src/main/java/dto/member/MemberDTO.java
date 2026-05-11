package dto.member;

public class MemberDTO {

    // ── MEMBER 테이블 컬럼 
    private int     id;
    private Integer userId;              // user_id  (FK → USER.id)

    private String  purpose;            // ENUM('diet','balance','bulk-up')
    private String  experience;         // ENUM('first(0)','beginner(<1)','intermediate(1~3)','high'(>3)')'

    private int     height;             // height INTEGER
    private int     weight;             // weight INTEGER
    private String  diet;               // ENUM('YES','Intermediate','NO')
    private String  exerciseCountGoal;  // DB: exerciseCount_goal

    private String  address;
    private double  latitude;
    private double  longitude;
    private String  goals;              // goals VARCHAR(100)

    // ── JOIN용 필드 (USER 테이블) ─────────────────────────────
    private String  email;
    private String  nickname;
    private String  profile_image;
    private String  role;
    private boolean email_verified;
    private String  provider;         // USER.provider

    private int     age;                // USER.age (JOIN용)
    private String  gender;				// USER.gender ENUM('MALE','FEMALE')
    private String  name;				// USER.name (JOIN용)

    // ── JOIN용 필드 (MEMBERSHIP_PT 테이블) ────────────────────
    private Integer trainerId;         // MEMBERSHIP_PT.trainer_id
    private Integer gymId;             // MEMBERSHIP_PT.gym_id
    private String  nextSession;       // MEMBERSHIP_PT.next_session
    private int     lessonCount;       // MEMBERSHIP_PT.lesson_count
    private String  lastSession;       // MEMBERSHIP_PT.last_session
    private String  status;            // MEMBERSHIP_PT.status ENUM('active','expired')

    public MemberDTO() {}

	public MemberDTO(int id, Integer userId, String purpose, String experience, int height, int weight, String diet,
			String exerciseCountGoal, String address, double latitude, double longitude, String goals, String email,
			String nickname, String profile_image, String role, boolean email_verified, String provider, int age,
			String gender, String name, Integer trainerId, Integer gymId, String nextSession, int lessonCount,
			String lastSession, String status) {
		super();
		this.id = id;
		this.userId = userId;
		this.purpose = purpose;
		this.experience = experience;
		this.height = height;
		this.weight = weight;
		this.diet = diet;
		this.exerciseCountGoal = exerciseCountGoal;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.goals = goals;
		this.email = email;
		this.nickname = nickname;
		this.profile_image = profile_image;
		this.role = role;
		this.email_verified = email_verified;
		this.provider = provider;
		this.age = age;
		this.gender = gender;
		this.name = name;
		this.trainerId = trainerId;
		this.gymId = gymId;
		this.nextSession = nextSession;
		this.lessonCount = lessonCount;
		this.lastSession = lastSession;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getDiet() {
		return diet;
	}

	public void setDiet(String diet) {
		this.diet = diet;
	}

	public String getExerciseCountGoal() {
		return exerciseCountGoal;
	}

	public void setExerciseCountGoal(String exerciseCountGoal) {
		this.exerciseCountGoal = exerciseCountGoal;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getGoals() {
		return goals;
	}

	public void setGoals(String goals) {
		this.goals = goals;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile_image() {
		return profile_image;
	}

	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isEmail_verified() {
		return email_verified;
	}

	public void setEmail_verified(boolean email_verified) {
		this.email_verified = email_verified;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(Integer trainerId) {
		this.trainerId = trainerId;
	}

	public Integer getGymId() {
		return gymId;
	}

	public void setGymId(Integer gymId) {
		this.gymId = gymId;
	}

	public String getNextSession() {
		return nextSession;
	}

	public void setNextSession(String nextSession) {
		this.nextSession = nextSession;
	}

	public int getLessonCount() {
		return lessonCount;
	}

	public void setLessonCount(int lessonCount) {
		this.lessonCount = lessonCount;
	}

	public String getLastSession() {
		return lastSession;
	}

	public void setLastSession(String lastSession) {
		this.lastSession = lastSession;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", userId=" + userId + ", purpose=" + purpose + ", experience=" + experience
				+ ", height=" + height + ", weight=" + weight + ", diet=" + diet + ", exerciseCountGoal="
				+ exerciseCountGoal + ", address=" + address + ", latitude=" + latitude + ", longitude=" + longitude
				+ ", goals=" + goals + ", email=" + email + ", nickname=" + nickname + ", profile_image="
				+ profile_image + ", role=" + role + ", email_verified=" + email_verified + ", provider=" + provider
				+ ", age=" + age + ", gender=" + gender + ", name=" + name + ", trainerId=" + trainerId + ", gymId="
				+ gymId + ", nextSession=" + nextSession + ", lessonCount=" + lessonCount + ", lastSession="
				+ lastSession + ", status=" + status + "]";
	}
	
}
