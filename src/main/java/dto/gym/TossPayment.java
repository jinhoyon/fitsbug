package dto.gym;

import java.sql.Timestamp;

public class TossPayment {
	private int id;
	private int userId;
	private String paymentKey;
	private String orderId;
	private long amount;
	private String status;
	private Timestamp createdAt;
	public TossPayment() {
		super();
	}
	public TossPayment(int id, int userId, String paymentKey, String orderId, long amount, String status,
			Timestamp createdAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.paymentKey = paymentKey;
		this.orderId = orderId;
		this.amount = amount;
		this.status = status;
		this.createdAt = createdAt;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public long getAmount() {
		return amount;
	}
	public void setAmount(long amount) {
		this.amount = amount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "TossPayment [id=" + id + ", userId=" + userId + ", paymentKey=" + paymentKey + ", orderId=" + orderId
				+ ", amount=" + amount + ", status=" + status + ", createdAt=" + createdAt + "]";
	}
	
	
}
