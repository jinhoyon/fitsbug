package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ TRAINER 테이블
 * id, user_id, trainer_type(FREELANCE/GYM_EMPLOYED/GYM_RENTAL),
 * gym_id, gym_join_code, business_registration_num, br_file,
 * has_homeGym, visit_service, description,
 * address, address_detail, postcode, latitude, longitude,
 * approval_status, created_at, is_verified
 *
 * + JOIN용: name, nickname, profileImg (USER 테이블)
 * + 화면 표시용: specialty, rating, price10, price1, career (계산/조인 결과)
 */
public class TrainerDTO {

    // ── TRAINER 테이블 컬럼 ─────────────────────────────────────
    private int     id;
    private Integer userId;                      // user_id (FK)
    private String  trainerType;                 // ENUM('FREELANCE','GYM_EMPLOYED','GYM_RENTAL')
    private Integer gymId;
    private String  gymJoinCode;                 // gym_join_code
    private String  businessRegistrationNum;     // business_registration_num
    private String  brFile;                      // br_file
    private boolean hasHomeGym;                  // has_homeGym
    private boolean visitService;               // visit_service
    private String  description;
    private String  address;
    private String  addressDetail;              // address_detail
    private String  postcode;
    private double  latitude;
    private double  longitude;
    private String  approvalStatus;             // ENUM('PENDING','APPROVED','REJECTED')
    private LocalDateTime createdAt;
    private int     isVerified;                 // is_verified (0/1)

    // ── JOIN용 / 화면 표시용 필드 ──────────────────────────────
    private String  name;           // USER.name
    private String  nickname;       // USER.nickname
    private String  email;          // USER.email
    private String  profileImg;     // USER.profileImg
    private String  specialty;      // 트레이너 전문 분야 (집계용)
    private double  rating;         // 평균 평점 (집계용)
    private double  similarity;     // 매칭 점수
    private int     price10;        // 10회 패키지 가격
    private int     price1;         // 1회 가격
    private String  career;         // 경력 요약
    private int     minPrice;       // 최저가 (trainer_pricing 집계)

    public TrainerDTO() {}

    // ── TRAINER 테이블 필드 getter/setter ───────────────────────

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getTrainerType() { return trainerType; }
    public void setTrainerType(String trainerType) { this.trainerType = trainerType; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public String getGymJoinCode() { return gymJoinCode; }
    public void setGymJoinCode(String gymJoinCode) { this.gymJoinCode = gymJoinCode; }

    public String getBusinessRegistrationNum() { return businessRegistrationNum; }
    public void setBusinessRegistrationNum(String businessRegistrationNum) { this.businessRegistrationNum = businessRegistrationNum; }

    public String getBrFile() { return brFile; }
    public void setBrFile(String brFile) { this.brFile = brFile; }

    public boolean isHasHomeGym() { return hasHomeGym; }
    public void setHasHomeGym(boolean hasHomeGym) { this.hasHomeGym = hasHomeGym; }

    public boolean isVisitService() { return visitService; }
    public void setVisitService(boolean visitService) { this.visitService = visitService; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getAddressDetail() { return addressDetail; }
    public void setAddressDetail(String addressDetail) { this.addressDetail = addressDetail; }

    public String getPostcode() { return postcode; }
    public void setPostcode(String postcode) { this.postcode = postcode; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public int getIsVerified() { return isVerified; }
    public void setIsVerified(int isVerified) { this.isVerified = isVerified; }

    // ── JOIN / 화면용 ────────────────────────────────────────────
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getProfileImg() { return profileImg; }
    public void setProfileImg(String profileImg) { this.profileImg = profileImg; }

    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public double getSimilarity() { return similarity; }
    public void setSimilarity(double similarity) { this.similarity = similarity; }

    public int getPrice10() { return price10; }
    public void setPrice10(int price10) { this.price10 = price10; }

    public int getPrice1() { return price1; }
    public void setPrice1(int price1) { this.price1 = price1; }

    public String getCareer() { return career; }
    public void setCareer(String career) { this.career = career; }

    public int getMinPrice() { return minPrice; }
    public void setMinPrice(int minPrice) { this.minPrice = minPrice; }

	@Override
	public String toString() {
		return "TrainerDTO [id=" + id + ", userId=" + userId + ", trainerType=" + trainerType + ", gymId=" + gymId
				+ ", gymJoinCode=" + gymJoinCode + ", businessRegistrationNum=" + businessRegistrationNum + ", brFile="
				+ brFile + ", hasHomeGym=" + hasHomeGym + ", visitService=" + visitService + ", description="
				+ description + ", address=" + address + ", addressDetail=" + addressDetail + ", postcode=" + postcode
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", approvalStatus=" + approvalStatus
				+ ", createdAt=" + createdAt + ", isVerified=" + isVerified + ", name=" + name + ", nickname="
				+ nickname + ", email=" + email + ", profileImg=" + profileImg + ", specialty=" + specialty
				+ ", rating=" + rating + ", similarity=" + similarity + ", price10=" + price10 + ", price1=" + price1
				+ ", career=" + career + ", minPrice=" + minPrice + "]";
	}


}
