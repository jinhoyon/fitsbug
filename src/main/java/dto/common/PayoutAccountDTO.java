package dto.common;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Shared PAYOUT_ACCOUNT table DTO used across member and trainer modules.
 */
public class PayoutAccountDTO {

    private int id;
    private int trainerId;
    private String trainerType;
    private Integer gymId;
    private BigDecimal commissionRate;
    private String businessRegistrationNum;
    private String residentRegistrationNum;
    private String bankName;
    private String accountNumber;
    private boolean active;
    private LocalDateTime createdAt;

    public PayoutAccountDTO() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
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

    public BigDecimal getCommissionRate() {
        return commissionRate;
    }

    public void setCommissionRate(BigDecimal commissionRate) {
        this.commissionRate = commissionRate;
    }

    public void setCommissionRate(double commissionRate) {
        this.commissionRate = BigDecimal.valueOf(commissionRate);
    }

    public String getBusinessRegistrationNum() {
        return businessRegistrationNum;
    }

    public void setBusinessRegistrationNum(String businessRegistrationNum) {
        this.businessRegistrationNum = businessRegistrationNum;
    }

    public String getResidentRegistrationNum() {
        return residentRegistrationNum;
    }

    public void setResidentRegistrationNum(String residentRegistrationNum) {
        this.residentRegistrationNum = residentRegistrationNum;
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

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setCreatedAt(String createdAt) {
        if (createdAt != null && !createdAt.isEmpty()) {
            this.createdAt = LocalDateTime.parse(createdAt.replace(' ', 'T'));
        }
    }
}
