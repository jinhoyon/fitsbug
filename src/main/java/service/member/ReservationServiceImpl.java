package service.member;

import java.sql.Timestamp;

import dao.member.MembershipDAO;
import dao.member.MembershipDAOImpl;
import dao.member.ReservationDAO;
import dao.member.ReservationDAOImpl;
import dto.common.NotificationDTO;
import dto.member.ReservationDTO;

public class ReservationServiceImpl implements ReservationService {

    private ReservationDAO reservationDAO = new ReservationDAOImpl();
    private MembershipDAO membershipDAO = new MembershipDAOImpl();
    private NotificationService notificationService = new NotificationServiceImpl();

    /**
     * 🔥 예약 생성
     */
    @Override
    public void reserve(String email, String trainerEmail, Timestamp time) {

        // 1. 예약 저장
        ReservationDTO dto = new ReservationDTO();
        dto.setMemberEmail(email);
        dto.setTrainerEmail(trainerEmail);
        dto.setReservationTime(time);

        reservationDAO.insert(dto);

        // 2. 회원권 차감
        membershipDAO.decreaseCount(email);

        // 3. 🔥 사용자 알림
        NotificationDTO userNoti = new NotificationDTO();
        userNoti.setEmail(email);
        userNoti.setType("reservation");
        userNoti.setMessage("PT 예약이 확정되었습니다");
        userNoti.setUrl("mypage");

        notificationService.create(userNoti);

        // 4. 🔥 트레이너 알림
        NotificationDTO trainerNoti = new NotificationDTO();
        trainerNoti.setEmail("trainerEmail");
        trainerNoti.setType("reservation");
        trainerNoti.setMessage("새로운 PT 예약이 들어왔습니다");
        trainerNoti.setUrl("trainerPage");

        notificationService.create(trainerNoti);
    }

    /**
     * 🔥 다음 수업 조회 (추가된 기능)
     */
    @Override
    public ReservationDTO getNextReservation(String email, String trainerEmail) {
        return reservationDAO.getNextReservation(email, trainerEmail);
    }
}