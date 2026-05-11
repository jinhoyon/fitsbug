package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ trainer_pricing 테이블 (신규)
 * id, trainer_id, label, session_count, price,
 * is_popular, is_active, created_at
 */
public class TrainerPricingDTO {

    private int    id;
    private int    trainerId;      // trainer_id (FK)
    private String label;         // 이용권 이름 (예: "10회 패키지")
    private int    sessionCount;  // session_count DEFAULT 1
    private int    price;
    private boolean isPopular;    // is_popular DEFAULT 0
    private boolean isActive;     // is_active  DEFAULT 1
    private LocalDateTime createdAt;

    public TrainerPricingDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public int getSessionCount() { return sessionCount; }
    public void setSessionCount(int sessionCount) { this.sessionCount = sessionCount; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public boolean isPopular() { return isPopular; }
    public void setPopular(boolean isPopular) { this.isPopular = isPopular; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
