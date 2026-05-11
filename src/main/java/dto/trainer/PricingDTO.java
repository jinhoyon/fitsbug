package dto.trainer;

public class PricingDTO {
    private int id;
    private int trainerId;
    private String label;
    private int sessionCount;
    private int price;
    private boolean popular;
    private boolean active;

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

    public boolean isPopular() { return popular; }
    public void setPopular(boolean popular) { this.popular = popular; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
