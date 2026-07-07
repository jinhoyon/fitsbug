package dto.common;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Shared PAYMENT table DTO used across member, gym, and trainer modules.
 */
public class Payment {

    private Integer id;
    private Integer userId;
    private String userName;
    private Integer membershipId;
    private Integer mpId;
    private Integer gymId;
    private Integer trainerId;
    private Timestamp paymentDate;
    private BigDecimal paymentPrice;
    private BigDecimal paymentFee;
    private String method;
    private String status;
    private String paymentType;
    private Timestamp canceledAt;
    private String reason;
    private String orderId;

    // JOIN / display fields (gym refund list)
    private String memberName;
    private String membershipName;

    public Payment() {}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getPaymentNum() {
        return id;
    }

    public void setPaymentNum(Integer paymentNum) {
        this.id = paymentNum;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getMembershipId() {
        return membershipId;
    }

    public void setMembershipId(Integer membershipId) {
        this.membershipId = membershipId;
    }

    public Integer getMembershipNum() {
        return membershipId;
    }

    public void setMembershipNum(Integer membershipNum) {
        this.membershipId = membershipNum;
    }

    public Integer getMpId() {
        return mpId;
    }

    public void setMpId(Integer mpId) {
        this.mpId = mpId;
    }

    public Integer getMrNum() {
        return mpId;
    }

    public void setMrNum(Integer mrNum) {
        this.mpId = mrNum;
    }

    public Integer getGymId() {
        return gymId;
    }

    public void setGymId(Integer gymId) {
        this.gymId = gymId;
    }

    public Integer getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(Integer trainerId) {
        this.trainerId = trainerId;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        if (paymentDate != null && !paymentDate.isEmpty()) {
            this.paymentDate = Timestamp.valueOf(paymentDate);
        }
    }

    public BigDecimal getPaymentPrice() {
        return paymentPrice;
    }

    public void setPaymentPrice(BigDecimal paymentPrice) {
        this.paymentPrice = paymentPrice;
    }

    public void setPaymentPrice(double paymentPrice) {
        this.paymentPrice = BigDecimal.valueOf(paymentPrice);
    }

    public BigDecimal getPaymentFee() {
        return paymentFee;
    }

    public void setPaymentFee(BigDecimal paymentFee) {
        this.paymentFee = paymentFee;
    }

    public void setPaymentFee(double paymentFee) {
        this.paymentFee = BigDecimal.valueOf(paymentFee);
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public Timestamp getCanceledAt() {
        return canceledAt;
    }

    public void setCanceledAt(Timestamp canceledAt) {
        this.canceledAt = canceledAt;
    }

    public void setCanceledAt(String canceledAt) {
        if (canceledAt != null && !canceledAt.isEmpty()) {
            this.canceledAt = Timestamp.valueOf(canceledAt);
        }
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMembershipName() {
        return membershipName;
    }

    public void setMembershipName(String membershipName) {
        this.membershipName = membershipName;
    }
}
