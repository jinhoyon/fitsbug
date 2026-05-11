package service.member;

import java.sql.Timestamp;

import dto.member.ReservationDTO;

public interface ReservationService {
	void reserve(String email, String trainerEmail, Timestamp time);
	
    ReservationDTO getNextReservation(String memberEmail, String trainerEmail);
}