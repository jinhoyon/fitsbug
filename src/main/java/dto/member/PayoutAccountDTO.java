package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ PAYOUT_ACCOUNT 테이블 (신규)
 * id, trainer_id, trainer_type(FREELANCE_BUSINESS/FREELANCE_INDIVIDUAL/
 *   GYM_EMPLOYEE/GYM_COMMISSION/GYM_RENTAL),
 * gym_id, commission_rate, business_registration_num, resident_registration_num,
 * bank_name, account_number, is_active, created_at
 */
public class PayoutAccountDTO {

    private int     id;
    private int     trainerId;                 // trainer_id (FK → TRAINER.id)
    private String  trainerType;               // ENUM
    private Integer gymId;
    private double  commissionRate;            // commission_rate DECIMAL(5,2)
    private String  businessRegistrationNum;   // business_registration_num
    private String  residentRegistrationNum;   // resident_registration_num
    private String  bankName;
    private String  accountNumber;
    private boolean isActive;                  // is_active DEFAULT 1
    private LocalDateTime createdAt;

    public PayoutAccountDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getTrainerType() { return trainerType; }
    public void setTrainerType(String trainerType) { this.trainerType = trainerType; }

    public Integer getGymId() { return gymId; }
    public void setGymId(Integer gymId) { this.gymId = gymId; }

    public double getCommissionRate() { return commissionRate; }
    public void setCommissionRate(double commissionRate) { this.commissionRate = commissionRate; }

    public String getBusinessRegistrationNum() { return businessRegistrationNum; }
    public void setBusinessRegistrationNum(String businessRegistrationNum) { this.businessRegistrationNum = businessRegistrationNum; }

    public String getResidentRegistrationNum() { return residentRegistrationNum; }
    public void setResidentRegistrationNum(String residentRegistrationNum) { this.residentRegistrationNum = residentRegistrationNum; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
