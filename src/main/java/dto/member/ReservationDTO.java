package dto.member;

import java.sql.Timestamp;

public class ReservationDTO {
	private int id;
    private String memberEmail;
    private String trainerEmail;
    private Timestamp reservationTime;
    private Timestamp classTime;
    private String status;
    
	public ReservationDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReservationDTO(int id, String memberEmail, String trainerEmail, Timestamp reservationTime, Timestamp classTime,
			String status) {
		super();
		this.id = id;
		this.memberEmail = memberEmail;
		this.trainerEmail = trainerEmail;
		this.reservationTime = reservationTime;
		this.classTime = classTime;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getTrainerEmail() {
		return trainerEmail;
	}

	public void setTrainerEmail(String trainerEmail) {
		this.trainerEmail = trainerEmail;
	}

	public Timestamp getReservationTime() {
		return reservationTime;
	}

	public void setReservationTime(Timestamp reservationTime) {
		this.reservationTime = reservationTime;
	}

	public Timestamp getClassTime() {
		return classTime;
	}

	public void setClassTime(Timestamp classTime) {
		this.classTime = classTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}