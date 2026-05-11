package dto.gym;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {
	private Integer paymentNum;
    private Integer userId;
    private String userName;

    private Integer membershipNum;
    private Integer mrNum;
    private Integer gymId;
    private Integer trainerId;

    private Timestamp paymentDate;
    private BigDecimal paymentPrice;
    private BigDecimal paymentFee;

    private String method;
    private String status;
    private String paymentType;

    private String memberName;
    private String membershipName;
    private String reason;
    private Timestamp canceledAt;
    private String orderId;
	public Payment() {
		super();
	}
	
	

	



	public Payment(Integer paymentNum, Integer userId, String userName, Integer membershipNum, Integer mrNum,
			Integer gymId, Integer trainerId, Timestamp paymentDate, BigDecimal paymentPrice, BigDecimal paymentFee,
			String method, String status, String paymentType, String memberName, String membershipName, String reason,
			Timestamp canceledAt, String orderId) {
		super();
		this.paymentNum = paymentNum;
		this.userId = userId;
		this.userName = userName;
		this.membershipNum = membershipNum;
		this.mrNum = mrNum;
		this.gymId = gymId;
		this.trainerId = trainerId;
		this.paymentDate = paymentDate;
		this.paymentPrice = paymentPrice;
		this.paymentFee = paymentFee;
		this.method = method;
		this.status = status;
		this.paymentType = paymentType;
		this.memberName = memberName;
		this.membershipName = membershipName;
		this.reason = reason;
		this.canceledAt = canceledAt;
		this.orderId = orderId;
	}




	


	public String getOrderId() {
		return orderId;
	}







	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}







	public Integer getPaymentNum() {
		return paymentNum;
	}



	public void setPaymentNum(Integer paymentNum) {
		this.paymentNum = paymentNum;
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



	public Integer getMembershipNum() {
		return membershipNum;
	}



	public void setMembershipNum(Integer membershipNum) {
		this.membershipNum = membershipNum;
	}



	public Integer getMrNum() {
		return mrNum;
	}



	public void setMrNum(Integer mrNum) {
		this.mrNum = mrNum;
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



	public BigDecimal getPaymentPrice() {
		return paymentPrice;
	}



	public void setPaymentPrice(BigDecimal paymentPrice) {
		this.paymentPrice = paymentPrice;
	}



	public BigDecimal getPaymentFee() {
		return paymentFee;
	}



	public void setPaymentFee(BigDecimal paymentFee) {
		this.paymentFee = paymentFee;
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



	public String getReason() {
		return reason;
	}



	public void setReason(String reason) {
		this.reason = reason;
	}



	public Timestamp getCanceledAt() {
		return canceledAt;
	}



	public void setCanceledAt(Timestamp canceledAt) {
		this.canceledAt = canceledAt;
	}







	@Override
	public String toString() {
		return "Payment [paymentNum=" + paymentNum + ", userId=" + userId + ", userName=" + userName
				+ ", membershipNum=" + membershipNum + ", mrNum=" + mrNum + ", gymId=" + gymId + ", trainerId="
				+ trainerId + ", paymentDate=" + paymentDate + ", paymentPrice=" + paymentPrice + ", paymentFee="
				+ paymentFee + ", method=" + method + ", status=" + status + ", paymentType=" + paymentType
				+ ", memberName=" + memberName + ", membershipName=" + membershipName + ", reason=" + reason
				+ ", canceledAt=" + canceledAt + ", orderId=" + orderId + "]";
	}



	

	

	

	
	
}
