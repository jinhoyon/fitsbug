package dto.member;

import java.time.LocalDateTime;

/**
 * ↔ SETTLEMENT 테이블 (신규)
 * id, target_id, target_type(TRAINER/GYM), settlement_month, settlement_deadline,
 * total_sales, total_fee, net_amount, bank_name, account_number,
 * status(정산대기/정산완료), completed_at, memo
 */
public class SettlementDTO {

    private int    id;
    private int    targetId;           // target_id (트레이너 또는 헬스장 ID)
    private String targetType;         // ENUM('TRAINER','GYM')
    private String settlementMonth;    // settlement_month
    private String settlementDeadline; // settlement_deadline
    private double totalSales;         // total_sales
    private double totalFee;           // total_fee
    private double netAmount;          // net_amount
    private String bankName;
    private String accountNumber;
    private String status;             // ENUM('정산대기','정산완료')
    private LocalDateTime completedAt;
    private String memo;

    public SettlementDTO() {}

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

    public double getTotalSales() { return totalSales; }
    public void setTotalSales(double totalSales) { this.totalSales = totalSales; }

    public double getTotalFee() { return totalFee; }
    public void setTotalFee(double totalFee) { this.totalFee = totalFee; }

    public double getNetAmount() { return netAmount; }
    public void setNetAmount(double netAmount) { this.netAmount = netAmount; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }

    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
}
