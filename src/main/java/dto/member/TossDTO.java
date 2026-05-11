package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ TOSS 테이블 (신규)
 * id, user_id, payment_key, order_id, amount, status, created_at
 */
public class TossDTO {

    private int    id;
    private int    userId;       // user_id (FK → USER.id)
    private String paymentKey;   // payment_key
    private String orderId;      // order_id
    private long   amount;
    private String status;
    private LocalDateTime createdAt;

    public TossDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getPaymentKey() { return paymentKey; }
    public void setPaymentKey(String paymentKey) { this.paymentKey = paymentKey; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public long getAmount() { return amount; }
    public void setAmount(long amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
