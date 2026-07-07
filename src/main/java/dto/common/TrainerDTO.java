package dto.common;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Shared TRAINER table DTO used across member discovery, trainer app, and gym modules.
 */
public class TrainerDTO {

    private int id;
    private Integer userId;
    private String trainerType;
    private Integer gymId;
    private String gymJoinCode;
    private String businessRegistrationNum;
    private String brFile;
    private boolean hasHomeGym;
    private boolean visitService;
    private String description;
    private String address;
    private String addressDetail;
    private String postcode;
    private Double latitude;
    private Double longitude;
    private String approvalStatus;
    private LocalDateTime createdAt;
    private boolean verified;

    // JOIN / display fields
    private String name;
    private String nickname;
    private String email;
    private String profileImg;
    private String specialty;
    private double rating;
    private double similarity;
    private int price10;
    private int price1;
    private String career;
    private int minPrice;

    public TrainerDTO() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTrainerId() {
        return id;
    }

    public void setTrainerId(int trainerId) {
        this.id = trainerId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTrainerType() {
        return trainerType;
    }

    public void setTrainerType(String trainerType) {
        this.trainerType = trainerType;
    }

    public Integer getGymId() {
        return gymId;
    }

    public void setGymId(Integer gymId) {
        this.gymId = gymId;
    }

    public String getGymJoinCode() {
        return gymJoinCode;
    }

    public void setGymJoinCode(String gymJoinCode) {
        this.gymJoinCode = gymJoinCode;
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

    public boolean isHasHomeGym() {
        return hasHomeGym;
    }

    public void setHasHomeGym(boolean hasHomeGym) {
        this.hasHomeGym = hasHomeGym;
    }

    public boolean isVisitService() {
        return visitService;
    }

    public void setVisitService(boolean visitService) {
        this.visitService = visitService;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude != null ? latitude.doubleValue() : null;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude != null ? longitude.doubleValue() : null;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setCreatedAt(String createdAt) {
        // Trainer listings occasionally map created_at as string.
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public int getIsVerified() {
        return verified ? 1 : 0;
    }

    public void setIsVerified(int isVerified) {
        this.verified = isVerified != 0;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfileImg() {
        return profileImg;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public double getSimilarity() {
        return similarity;
    }

    public void setSimilarity(double similarity) {
        this.similarity = similarity;
    }

    public int getPrice10() {
        return price10;
    }

    public void setPrice10(int price10) {
        this.price10 = price10;
    }

    public int getPrice1() {
        return price1;
    }

    public void setPrice1(int price1) {
        this.price1 = price1;
    }

    public String getCareer() {
        return career;
    }

    public void setCareer(String career) {
        this.career = career;
    }

    public int getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(int minPrice) {
        this.minPrice = minPrice;
    }
}
