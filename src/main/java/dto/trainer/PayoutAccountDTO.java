package dto.trainer;

import java.math.BigDecimal;

public class PayoutAccountDTO {
    private int id;
    private int trainerId;
    // FREELANCE_BUSINESS | FREELANCE_INDIVIDUAL | GYM_EMPLOYEE | GYM_COMMISSION | GYM_RENTAL
    private String trainerType;
    private Integer gymId;
    private BigDecimal commissionRate;       // trainer's share %, e.g. 70.00 for 70%
    private String businessRegistrationNum;  // FREELANCE_BUSINESS
    private String residentRegistrationNum;  // FREELANCE_INDIVIDUAL (원천징수용)
    private String bankName;
    private String accountNumber;
    private boolean isActive;
    private String createdAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getTrainerType() { return trainerType; }
    public void setTrainerType(String trainerType) { this.trainerType = trainerType; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public BigDecimal getCommissionRate() { return commissionRate; }
    public void setCommissionRate(BigDecimal commissionRate) { this.commissionRate = commissionRate; }

    public String getBusinessRegistrationNum() { return businessRegistrationNum; }
    public void setBusinessRegistrationNum(String businessRegistrationNum) { this.businessRegistrationNum = businessRegistrationNum; }

    public String getResidentRegistrationNum() { return residentRegistrationNum; }
    public void setResidentRegistrationNum(String residentRegistrationNum) { this.residentRegistrationNum = residentRegistrationNum; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
