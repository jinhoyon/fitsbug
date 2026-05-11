package dto.trainer;

import java.math.BigDecimal;

public class SettlementDTO {
    private int id;
    private int targetId;
    private String targetType;
    private String settlementMonth;
    private String settlementDeadline;
    private BigDecimal totalSales;
    private BigDecimal totalFee;
    private BigDecimal netAmount;
    private String bankName;
    private String accountNumber;
    private String status;
    private String completedAt;
    private String memo;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTargetId() { return targetId; }
    public void setTargetId(int targetId) { this.targetId = targetId; }

    public String getTargetType() { return targetType; }
    public void setTargetType(String targetType) { this.targetType = targetType; }

    public String getSettlementMonth() { return settlementMonth; }
    public void setSettlementMonth(String settlementMonth) { this.settlementMonth = settlementMonth; }

    public String getSettlementDeadline() { return settlementDeadline; }
    public void setSettlementDeadline(String settlementDeadline) { this.settlementDeadline = settlementDeadline; }

    public BigDecimal getTotalSales() { return totalSales; }
    public void setTotalSales(BigDecimal totalSales) { this.totalSales = totalSales; }

    public BigDecimal getTotalFee() { return totalFee; }
    public void setTotalFee(BigDecimal totalFee) { this.totalFee = totalFee; }

    public BigDecimal getNetAmount() { return netAmount; }
    public void setNetAmount(BigDecimal netAmount) { this.netAmount = netAmount; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCompletedAt() { return completedAt; }
    public void setCompletedAt(String completedAt) { this.completedAt = completedAt; }

    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
}
