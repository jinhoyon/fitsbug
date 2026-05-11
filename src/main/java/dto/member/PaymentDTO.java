package dto.member;

public class PaymentDTO {

    private int    id;
    private Integer userId;        // user_id (FK → USER.id)
    private String userName;       // user_name

    private Integer membershipId;  // membership_id (FK → MEMBERSHIP.id)
    private Integer mpId;          // mp_id (FK → MEMBERSHIP_PT.id) ← 기존 mrId에서 수정

    private Integer gymId;
    private Integer trainerId;
    private String paymentDate;    // payment_date (DATETIME)
    private double paymentPrice;   // payment_price
    private double paymentFee;     // payment_fee
    private String method;
    private String status;         // 결제완료/취소완료/환불요청/환불완료
    private String paymentType;    // MEMBERSHIP / PT
    private String canceledAt;     // canceled_at
    private String reason;

    public PaymentDTO() {}

	public PaymentDTO(int id, Integer userId, String userName, Integer membershipId, Integer mpId, Integer gymId,
			Integer trainerId, String paymentDate, double paymentPrice, double paymentFee, String method, String status,
			String paymentType, String canceledAt, String reason) {
		super();
		this.id = id;
		this.userId = userId;
		this.userName = userName;
		this.membershipId = membershipId;
		this.mpId = mpId;
		this.gymId = gymId;
		this.trainerId = trainerId;
		this.paymentDate = paymentDate;
		this.paymentPrice = paymentPrice;
		this.paymentFee = paymentFee;
		this.method = method;
		this.status = status;
		this.paymentType = paymentType;
		this.canceledAt = canceledAt;
		this.reason = reason;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public Integer getMpId() {
		return mpId;
	}

	public void setMpId(Integer mpId) {
		this.mpId = mpId;
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

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public double getPaymentPrice() {
		return paymentPrice;
	}

	public void setPaymentPrice(double paymentPrice) {
		this.paymentPrice = paymentPrice;
	}

	public double getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(double paymentFee) {
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

	public String getCanceledAt() {
		return canceledAt;
	}

	public void setCanceledAt(String canceledAt) {
		this.canceledAt = canceledAt;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "PaymentDTO [id=" + id + ", userId=" + userId + ", userName=" + userName + ", membershipId="
				+ membershipId + ", mpId=" + mpId + ", gymId=" + gymId + ", trainerId=" + trainerId + ", paymentDate="
				+ paymentDate + ", paymentPrice=" + paymentPrice + ", paymentFee=" + paymentFee + ", method=" + method
				+ ", status=" + status + ", paymentType=" + paymentType + ", canceledAt=" + canceledAt + ", reason="
				+ reason + "]";
	}

}
