package dao.member;

import dto.member.ReservationDTO;

public interface ReservationDAO {
	void insert(ReservationDTO dto);
	
    ReservationDTO getNextReservation(String memberEmail, String trainerEmail);
}