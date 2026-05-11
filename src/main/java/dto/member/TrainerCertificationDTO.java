package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ TRAINER_CERTIFICATION 테이블 (신규)
 * id, trainer_id, cert_name, issuing_org, issue_date, expiry_date,
 * cert_file, created_at
 */
public class TrainerCertificationDTO {

    private int    id;
    private int    trainerId;    // trainer_id (FK → TRAINER.id)
    private String certName;    // cert_name
    private String issuingOrg;  // issuing_org
    private String issueDate;   // issue_date (DATE)
    private String expiryDate;  // expiry_date (VARCHAR - '무기한' 포함)
    private String certFile;    // cert_file
    private LocalDateTime createdAt;

    public TrainerCertificationDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getCertName() { return certName; }
    public void setCertName(String certName) { this.certName = certName; }

    public String getIssuingOrg() { return issuingOrg; }
    public void setIssuingOrg(String issuingOrg) { this.issuingOrg = issuingOrg; }

    public String getIssueDate() { return issueDate; }
    public void setIssueDate(String issueDate) { this.issueDate = issueDate; }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

    public String getCertFile() { return certFile; }
    public void setCertFile(String certFile) { this.certFile = certFile; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
