package dto.trainer;

import java.math.BigDecimal;

public class TrainerDTO {
    private int trainerId;
    private int userId;
    private String trainerType;
    private Integer gymId;
    private String businessRegistrationNum;
    private String description;
    private String address;
    private String addressDetail;
    private String postcode;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private String approvalStatus;
    private boolean isVerified;

    // Populated via JOIN with user table (not stored in trainer table)
    private String name;
    private String email;
    private String createdAt;

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTrainerType() { return trainerType; }
    public void setTrainerType(String trainerType) { this.trainerType = trainerType; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public String getBusinessRegistrationNum() { return businessRegistrationNum; }
    public void setBusinessRegistrationNum(String businessRegistrationNum) { this.businessRegistrationNum = businessRegistrationNum; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getAddressDetail() { return addressDetail; }
    public void setAddressDetail(String addressDetail) { this.addressDetail = addressDetail; }

    public String getPostcode() { return postcode; }
    public void setPostcode(String postcode) { this.postcode = postcode; }

    public BigDecimal getLatitude() { return latitude; }
    public void setLatitude(BigDecimal latitude) { this.latitude = latitude; }

    public BigDecimal getLongitude() { return longitude; }
    public void setLongitude(BigDecimal longitude) { this.longitude = longitude; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }

    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean verified) { isVerified = verified; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
