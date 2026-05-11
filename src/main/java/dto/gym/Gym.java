package dto.gym;

import java.math.BigDecimal;

public class Gym {
	private Integer id;                         // id (PK, AUTO_INCREMENT)
    private Integer userId;                  // user_id (FK)
    private String name;                       // name
    private String backgroundImg;              // background_img
    private String businessRegistrationNum;    // business_registration_num (UNIQUE)
    private String brFile;                     // br_file
    private String phoneNum;                   // phone_num
    private String address;                    // address
    private String addressDetail;              // address_detail
    private String postcode;                   // postcode
    private BigDecimal latitude;               // latitude (decimal(10,7))
    private BigDecimal longitude;              // longitude (decimal(10,7))
    private String description;                // description (longtext)
    private String file;                       // file
    private String facility;                   // facility
    private String approvalStatus;             // approval_status (ENUM - 'PENDING', 'APPROVED', 'REJECTED')
    private String gymCode;                    // gym_code
    private String bankName;                   // bank_name
    private String accountNumber;              // account_number
    
	public Gym() {
		super();
	}

	public Gym(Integer id, Integer userId, String name, String backgroundImg, String businessRegistrationNum,
			String brFile, String phoneNum, String address, String addressDetail, String postcode, BigDecimal latitude,
			BigDecimal longitude, String description, String file, String facility, String approvalStatus,
			String gymCode, String bankName, String accountNumber) {
		super();
		this.id = id;
		this.userId = userId;
		this.name = name;
		this.backgroundImg = backgroundImg;
		this.businessRegistrationNum = businessRegistrationNum;
		this.brFile = brFile;
		this.phoneNum = phoneNum;
		this.address = address;
		this.addressDetail = addressDetail;
		this.postcode = postcode;
		this.latitude = latitude;
		this.longitude = longitude;
		this.description = description;
		this.file = file;
		this.facility = facility;
		this.approvalStatus = approvalStatus;
		this.gymCode = gymCode;
		this.bankName = bankName;
		this.accountNumber = accountNumber;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBackgroundImg() {
		return backgroundImg;
	}

	public void setBackgroundImg(String backgroundImg) {
		this.backgroundImg = backgroundImg;
	}

	public String getBusinessRegistrationNum() {
		return businessRegistrationNum;
	}

	public void setBusinessRegistrationNum(String businessRegistrationNum) {
		this.businessRegistrationNum = businessRegistrationNum;
	}

	public String getBrFile() {
		return brFile;
	}

	public void setBrFile(String brFile) {
		this.brFile = brFile;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public BigDecimal getLatitude() {
		return latitude;
	}

	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}

	public BigDecimal getLongitude() {
		return longitude;
	}

	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getFacility() {
		return facility;
	}

	public void setFacility(String facility) {
		this.facility = facility;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getGymCode() {
		return gymCode;
	}

	public void setGymCode(String gymCode) {
		this.gymCode = gymCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	@Override
	public String toString() {
		return "Gym [id=" + id + ", userId=" + userId + ", name=" + name + ", backgroundImg=" + backgroundImg
				+ ", businessRegistrationNum=" + businessRegistrationNum + ", brFile=" + brFile + ", phoneNum="
				+ phoneNum + ", address=" + address + ", addressDetail=" + addressDetail + ", postcode=" + postcode
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", description=" + description + ", file="
				+ file + ", facility=" + facility + ", approvalStatus=" + approvalStatus + ", gymCode=" + gymCode
				+ ", bankName=" + bankName + ", accountNumber=" + accountNumber + "]";
	}

	
}
