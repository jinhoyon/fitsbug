package dto.gym;

import java.math.BigDecimal;

public class SalesChart {
	private String label;  // 날짜 or 월
    private BigDecimal sales;
    private int percent;
	public SalesChart() {
		super();
	}
	public SalesChart(String label, BigDecimal sales, int percent) {
		super();
		this.label = label;
		this.sales = sales;
		this.percent = percent;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public BigDecimal getSales() {
		return sales;
	}
	public void setSales(BigDecimal sales) {
		this.sales = sales;
	}
	public int getPercent() {
		return percent;
	}
	public void setPercent(int percent) {
		this.percent = percent;
	}
	@Override
	public String toString() {
		return "SalesChart [label=" + label + ", sales=" + sales + ", percent=" + percent + "]";
	}
	
    
}
