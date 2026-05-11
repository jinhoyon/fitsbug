package dto.gym;

import java.math.BigDecimal;

public class Membership {
	private int membershipNum;
	private int gymNum;
	private String type;
	private int typeRep;
	private BigDecimal price;
	private Integer trainerNum;
	
	public Membership() {
		super();
	}

	

	public Membership(int membershipNum, int gymNum, String type, int typeRep, BigDecimal price, Integer trainerNum) {
		super();
		this.membershipNum = membershipNum;
		this.gymNum = gymNum;
		this.type = type;
		this.typeRep = typeRep;
		this.price = price;
		this.trainerNum = trainerNum;
	}


	
	public Integer getTrainerNum() {
		return trainerNum;
	}



	public void setTrainerNum(Integer trainerNum) {
		this.trainerNum = trainerNum;
	}



	public int getMembershipNum() {
		return membershipNum;
	}

	public void setMembershipNum(int membershipNum) {
		this.membershipNum = membershipNum;
	}

	public int getGymNum() {
		return gymNum;
	}

	public void setGymNum(int gymNum) {
		this.gymNum = gymNum;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getTypeRep() {
		return typeRep;
	}

	public void setTypeRep(int typeRep) {
		this.typeRep = typeRep;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}



	@Override
	public String toString() {
		return "Membership [membershipNum=" + membershipNum + ", gymNum=" + gymNum + ", type=" + type + ", typeRep="
				+ typeRep + ", price=" + price + ", trainerNum=" + trainerNum + "]";
	}

	
	
	
}
