package dto.gym;

import java.math.BigDecimal;

public class SalesSummary {
	private BigDecimal totalSales;
    private BigDecimal gymSales;
    private BigDecimal ptSales;
    private BigDecimal totalFee;
    private BigDecimal netSales;
    private Double growthRate;
	public SalesSummary() {
		super();
	}
	public SalesSummary(BigDecimal totalSales, BigDecimal gymSales, BigDecimal ptSales, BigDecimal totalFee,
			BigDecimal netSales, Double growthRate) {
		super();
		this.totalSales = totalSales;
		this.gymSales = gymSales;
		this.ptSales = ptSales;
		this.totalFee = totalFee;
		this.netSales = netSales;
		this.growthRate = growthRate;
	}
	public BigDecimal getTotalSales() {
		return totalSales;
	}
	public void setTotalSales(BigDecimal totalSales) {
		this.totalSales = totalSales;
	}
	public BigDecimal getGymSales() {
		return gymSales;
	}
	public void setGymSales(BigDecimal gymSales) {
		this.gymSales = gymSales;
	}
	public BigDecimal getPtSales() {
		return ptSales;
	}
	public void setPtSales(BigDecimal ptSales) {
		this.ptSales = ptSales;
	}
	public BigDecimal getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(BigDecimal totalFee) {
		this.totalFee = totalFee;
	}
	public BigDecimal getNetSales() {
		return netSales;
	}
	public void setNetSales(BigDecimal netSales) {
		this.netSales = netSales;
	}
	public Double getGrowthRate() {
		return growthRate;
	}
	public void setGrowthRate(Double growthRate) {
		this.growthRate = growthRate;
	}
	@Override
	public String toString() {
		return "SalesSummary [totalSales=" + totalSales + ", gymSales=" + gymSales + ", ptSales=" + ptSales
				+ ", totalFee=" + totalFee + ", netSales=" + netSales + ", growthRate=" + growthRate + "]";
	}
	
	
	
    
}
