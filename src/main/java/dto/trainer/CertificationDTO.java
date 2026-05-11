package dto.trainer;

public class CertificationDTO {
    private int id;
    private int trainerId;
    private String certName;
    private String issuingOrg;
    private String issueDate;
    private String expiryDate;
    private String certFile; // saved filename in ~/fitbull_uploads/
    private String createdAt;

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

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
