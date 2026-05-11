package dto.member;

/**
 * ↔ GYM 테이블
 *
 * DB 컬럼:
 *   id, user_id, name, background_img, business_registration_num, br_file,
 *   phone_num, address, address_detail, postcode,
 *   latitude, longitude,
 *   description, file, facility, approval_status,
 *   gym_code, bank_name, account_number
 *
 * 화면 표시용(집계/계산):
 *   specialty, rating, distance, score, price, image
 */
public class GymDTO {

    // ── DB 컬럼 ────────────────────────────────────────────────
    private int     id;                       // PK: id
    private Integer userId;                   // user_id FK
    private String  name;
    private String  backgroundImg;            // background_img
    private String  businessRegistrationNum;  // business_registration_num
    private String  brFile;                   // br_file
    private String  phoneNum;                 // phone_num
    private String  address;
    private String  addressDetail;            // address_detail ← 신규
    private String  postcode;                 // postcode       ← 신규
    private double  latitude;                 // latitude
    private double  longitude;                // longitude
    private String  description;
    private String  file;
    private String  facility;
    private String  approvalStatus;           // approval_status
    private String  gymCode;                  // gym_code
    private String  bankName;                 // bank_name
    private String  accountNumber;            // account_number

    // ── 화면 표시용 (DB 컬럼 아님, 집계/계산) ─────────────────
    private String  image;       // 대표 이미지 URL
    private String  specialty;   // 전문 분야 (화면 표시용)
    private double  rating;      // 평균 평점
    private double  distance;    // 사용자 현재위치 기준 거리(km)
    private double  score;       // 추천 점수
    private int     price;       // 대표 이용권 가격

    // ── 이전 코드 호환용 alias ─────────────────────────────────
    /** @deprecated id 사용 권장 */
    public int getGymId()         { return id; }
    public void setGymId(int id)  { this.id = id; }

    // ── 기본 생성자 ───────────────────────────────────────────
    public GymDTO() {}

    // ── DB 컬럼 getter / setter ──────────────────────────────

    public int getId()                { return id; }
    public void setId(int id)         { this.id = id; }

    public Integer getUserId()        { return userId; }
    public void setUserId(Integer v)  { this.userId = v; }

    public String getName()           { return name; }
    public void setName(String v)     { this.name = v; }

    public String getBackgroundImg()              { return backgroundImg; }
    public void setBackgroundImg(String v)        { this.backgroundImg = v; }

    public String getBusinessRegistrationNum()          { return businessRegistrationNum; }
    public void setBusinessRegistrationNum(String v)    { this.businessRegistrationNum = v; }

    public String getBrFile()         { return brFile; }
    public void setBrFile(String v)   { this.brFile = v; }

    public String getPhoneNum()       { return phoneNum; }
    public void setPhoneNum(String v) { this.phoneNum = v; }

    public String getAddress()        { return address; }
    public void setAddress(String v)  { this.address = v; }

    public String getAddressDetail()         { return addressDetail; }
    public void setAddressDetail(String v)   { this.addressDetail = v; }

    public String getPostcode()       { return postcode; }
    public void setPostcode(String v) { this.postcode = v; }

    public double getLatitude()         { return latitude; }
    public void setLatitude(double v)   { this.latitude = v; }

    public double getLongitude()        { return longitude; }
    public void setLongitude(double v)  { this.longitude = v; }

    public String getDescription()      { return description; }
    public void setDescription(String v){ this.description = v; }

    public String getFile()           { return file; }
    public void setFile(String v)     { this.file = v; }

    public String getFacility()       { return facility; }
    public void setFacility(String v) { this.facility = v; }

    public String getApprovalStatus()         { return approvalStatus; }
    public void setApprovalStatus(String v)   { this.approvalStatus = v; }

    public String getGymCode()        { return gymCode; }
    public void setGymCode(String v)  { this.gymCode = v; }

    public String getBankName()       { return bankName; }
    public void setBankName(String v) { this.bankName = v; }

    public String getAccountNumber()         { return accountNumber; }
    public void setAccountNumber(String v)   { this.accountNumber = v; }

    // ── 화면 표시용 getter / setter ───────────────────────────

    public String getImage()          { return image; }
    public void setImage(String v)    { this.image = v; }

    public String getSpecialty()      { return specialty; }
    public void setSpecialty(String v){ this.specialty = v; }

    public double getRating()         { return rating; }
    public void setRating(double v)   { this.rating = v; }

    public double getDistance()       { return distance; }
    public void setDistance(double v) { this.distance = v; }

    public double getScore()          { return score; }
    public void setScore(double v)    { this.score = v; }

    public int getPrice()             { return price; }
    public void setPrice(int v)       { this.price = v; }
	@Override
	public String toString() {
		return "GymDTO [id=" + id + ", userId=" + userId + ", name=" + name + ", backgroundImg=" + backgroundImg
				+ ", businessRegistrationNum=" + businessRegistrationNum + ", brFile=" + brFile + ", phoneNum="
				+ phoneNum + ", address=" + address + ", addressDetail=" + addressDetail + ", postcode=" + postcode
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", description=" + description + ", file="
				+ file + ", facility=" + facility + ", approvalStatus=" + approvalStatus + ", gymCode=" + gymCode
				+ ", bankName=" + bankName + ", accountNumber=" + accountNumber + ", image=" + image + ", specialty="
				+ specialty + ", rating=" + rating + ", distance=" + distance + ", score=" + score + ", price=" + price
				+ "]";
	}


}
