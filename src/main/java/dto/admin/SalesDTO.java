package dto.admin;

import java.sql.Timestamp;

public class SalesDTO {
	//공통 사용 DTO
	private Integer paymentNum; //매출, 결제
	private Timestamp paymentDate; //매출, 결제
	private Double paymentPrice; //매출, 결제
	private Integer membershipNum;
	private Integer mrNum;
	
	//정산용 DTO
	private Integer settlementNum;
	private Integer targetNum; //헬스장, 트레이너의 고유번호ID
	private String targetType; // ENUM 매칭
	private String settlementMonth;
	private String settlementDeadline;
	private Double totalSales;
	private Double totalFee;
	private Double totalAmount;
	private String bankName;
	private String accountNumber;
	private String settlementStatus; //ENUM 매칭
	private Timestamp completedAt;
	private String memo;
	
	//매출용 DTO
	private Integer gymId;
	private String gymName;
	private Integer trainerId;
	private String trainerName;
	private Double paymentFee;
	private Double paymentAmount; //payment테이블에 해당칼럼없음. 계산식 써야할듯
	
	//결제용 DTO
	private Integer userNum;
	private String userName;
	private String method;
	private String paymentStatus; //ENUM 매칭
	private Timestamp canceledAt;
	private String reason;
	
	//토스용 DTO
	private String tossPaymentKey;
	private String tossOrderId;
	
	// --- [6. 비즈니스 로직 메서드] ---
    // DB에 없는 netProfit을 가공해서 반환하는 메서드 예시
    public Double getPaymentAmount() {
    	if (this.paymentPrice != null && this.paymentFee != null) {
            this.paymentAmount= this.paymentPrice - this.paymentFee; // 필드에 값을 할당하여 경고 해결
            return this.paymentAmount;
        }
        return 0.0;
    }
    
    public Double getTotalAmount() {
    	if (this.totalSales != null && this.totalFee != null) {
            this.totalAmount= this.totalSales - this.totalFee; // 필드에 값을 할당하여 경고 해결
            return this.totalAmount;
        }
        return 0.0;
    }

	public SalesDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SalesDTO(Integer paymentNum, Timestamp paymentDate, Double paymentPrice, Integer membershipNum,
			Integer mrNum, Integer settlementNum, Integer targetNum, String targetType, String settlementMonth,
			String settlementDeadline, Double totalSales, Double totalFee, Double totalAmount, String bankName,
			String accountNumber, String settlementStatus, Timestamp completedAt, String memo, Integer gymId,
			String gymName, Integer trainerId, String trainerName, Double paymentFee, Double paymentAmount, Integer userNum,
			String userName, String method, String paymentStatus, Timestamp canceledAt, String reason,
			String tossPaymentKey, String tossOrderId) {
		super();
		this.paymentNum = paymentNum;
		this.paymentDate = paymentDate;
		this.paymentPrice = paymentPrice;
		this.membershipNum = membershipNum;
		this.mrNum = mrNum;
		this.settlementNum = settlementNum;
		this.targetNum = targetNum;
		this.targetType = targetType;
		this.settlementMonth = settlementMonth;
		this.settlementDeadline = settlementDeadline;
		this.totalSales = totalSales;
		this.totalFee = totalFee;
		this.totalAmount = totalAmount;
		this.bankName = bankName;
		this.accountNumber = accountNumber;
		this.settlementStatus = settlementStatus;
		this.completedAt = completedAt;
		this.memo = memo;
		this.gymId = gymId;
		this.gymName = gymName;
		this.trainerId = trainerId;
		this.trainerName = trainerName;
		this.paymentFee = paymentFee;
		this.paymentAmount = paymentAmount;
		this.userNum = userNum;
		this.userName = userName;
		this.method = method;
		this.paymentStatus = paymentStatus;
		this.canceledAt = canceledAt;
		this.reason = reason;
		this.tossPaymentKey = tossPaymentKey;
		this.tossOrderId = tossOrderId;
	}

	public Integer getPaymentNum() {
		return paymentNum;
	}

	public void setPaymentNum(Integer paymentNum) {
		this.paymentNum = paymentNum;
	}

	public Timestamp getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Timestamp paymentDate) {
		this.paymentDate = paymentDate;
	}

	public Double getPaymentPrice() {
		return paymentPrice;
	}

	public void setPaymentPrice(Double paymentPrice) {
		this.paymentPrice = paymentPrice;
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

	public Integer getSettlementNum() {
		return settlementNum;
	}

	public void setSettlementNum(Integer settlementNum) {
		this.settlementNum = settlementNum;
	}

	public Integer getTargetNum() {
		return targetNum;
	}

	public void setTargetNum(Integer targetNum) {
		this.targetNum = targetNum;
	}

	public String getTargetType() {
		return targetType;
	}

	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}

	public String getSettlementMonth() {
		return settlementMonth;
	}

	public void setSettlementMonth(String settlementMonth) {
		this.settlementMonth = settlementMonth;
	}

	public String getSettlementDeadline() {
		return settlementDeadline;
	}

	public void setSettlementDeadline(String settlementDeadline) {
		this.settlementDeadline = settlementDeadline;
	}

	public Double getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(Double totalSales) {
		this.totalSales = totalSales;
	}

	public Double getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(Double totalFee) {
		this.totalFee = totalFee;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
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

	public String getSettlementStatus() {
		return settlementStatus;
	}

	public void setSettlementStatus(String settlementStatus) {
		this.settlementStatus = settlementStatus;
	}

	public Timestamp getCompletedAt() {
		return completedAt;
	}

	public void setCompletedAt(Timestamp completedAt) {
		this.completedAt = completedAt;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Integer getGymId() {
		return gymId;
	}

	public void setGymId(Integer gymId) {
		this.gymId = gymId;
	}

	public String getGymName() {
		return gymName;
	}

	public void setGymName(String gymName) {
		this.gymName = gymName;
	}

	public Integer getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(Integer trainerId) {
		this.trainerId = trainerId;
	}

	public String getTrainerName() {
		return trainerName;
	}

	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}

	public Double getPaymentFee() {
		return paymentFee;
	}

	public void setPaymentFee(Double paymentFee) {
		this.paymentFee = paymentFee;
	}

	public Integer getUserNum() {
		return userNum;
	}

	public void setUserNum(Integer userNum) {
		this.userNum = userNum;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
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

	public String getTossPaymentKey() {
		return tossPaymentKey;
	}

	public void setTossPaymentKey(String tossPaymentKey) {
		this.tossPaymentKey = tossPaymentKey;
	}

	public String getTossOrderId() {
		return tossOrderId;
	}

	public void setTossOrderId(String tossOrderId) {
		this.tossOrderId = tossOrderId;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}
}