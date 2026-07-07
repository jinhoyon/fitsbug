package service.member;


import dao.member.PaymentDAO;
import dao.member.PaymentDAOImpl;
import dto.common.NotificationDTO;
import dto.common.Payment;

public class PaymentServiceImpl implements PaymentService {

    private PaymentDAO dao = new PaymentDAOImpl();
    private NotificationService notificationService = new NotificationServiceImpl();

    // =========================
    // 결제 생성 (READY 상태)
    // =========================
    @Override
    public Payment createPayment(Payment dto) {

        // 상태 초기화
        dto.setStatus("READY");

        // DB 저장
        dao.insert(dto);

        return dto;
    }

    // =========================
    // 결제 성공 처리
    // =========================
    @Override
    public void success(String orderId, String email) {

        // 1. 결제 상태 업데이트
        dao.updateStatus(orderId, "DONE");

        // 3. 알림 생성
        NotificationDTO n = new NotificationDTO();
        n.setEmail(email);
        n.setType("payment");
        n.setMessage("회원권 결제가 완료되었습니다");
        n.setUrl("mypage.jsp");

        notificationService.create(n);
    }

    @Override
    public Payment getActivePayment(String email) {
        return dao.findActiveByEmail(email);
    }

    @Override
    public void requestCancel(String orderId) {
        dao.updateStatus(orderId, "CANCEL_REQ");
    }

    @Override
    public void requestRefund(String orderId) {
        dao.updateStatus(orderId, "REFUND_REQ");
    }
}