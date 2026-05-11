package dto.gym;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Sales {
	private String orderId;
	private String memberName;
	private String membershipType; // day, month, pt
	private int typeRep; // 개월 / 횟수 / 일수
	private String trainerName;
	private Timestamp paymentDate;
	private BigDecimal paymentPrice;
	private BigDecimal paymentFee;
	private BigDecimal netPrice; // 계산값
	private String status;
	private Timestamp canceledAt;
	private String reason;
	private boolean started;
	private Timestamp startDate;

	public Sales() {
		super();
	}

	public Sales(String orderId, String memberName, String membershipType, int typeRep, String trainerName,
			Timestamp paymentDate, BigDecimal paymentPrice, BigDecimal paymentFee, BigDecimal netPrice, String status,
			Timestamp canceledAt, String reason, boolean started, Timestamp startDate) {
		super();
		this.orderId = orderId;
		this.memberName = memberName;
		this.membershipType = membershipType;
		this.typeRep = typeRep;
		this.trainerName = trainerName;
		this.paymentDate = paymentDate;
		this.paymentPrice = paymentPrice;
		this.paymentFee = paymentFee;
		this.netPrice = netPrice;
		this.status = status;
		this.canceledAt = canceledAt;
		this.reason = reason;
		this.started = started;
		this.startDate = startDate;
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

	public String getMembershipType() {
		return membershipType;
	}

	public void setMembershipType(String membershipType) {
		this.membershipType = membershipType;
	}

	public int getTypeRep() {
		return typeRep;
	}

	public void setTypeRep(int typeRep) {
		this.typeRep = typeRep;
	}

	public String getTrainerName() {
		return trainerName;
	}

	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
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

	public BigDecimal getNetPrice() {
		return netPrice;
	}

	public void setNetPrice(BigDecimal netPrice) {
		this.netPrice = netPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCanceledAt() {
		return canceledAt;
	}

	public void setCanceledAt(Timestamp canceledAt) {
		this.canceledAt = canceledAt;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public boolean isStarted() {
		return started;
	}

	public void setStarted(boolean started) {
		this.started = started;
	}

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	@Override
	public String toString() {
		return "Sales [orderId=" + orderId + ", memberName=" + memberName + ", membershipType=" + membershipType
				+ ", typeRep=" + typeRep + ", trainerName=" + trainerName + ", paymentDate=" + paymentDate
				+ ", paymentPrice=" + paymentPrice + ", paymentFee=" + paymentFee + ", netPrice=" + netPrice
				+ ", status=" + status + ", canceledAt=" + canceledAt + ", reason=" + reason + ", started=" + started
				+ ", startDate=" + startDate + "]";
	}

}
