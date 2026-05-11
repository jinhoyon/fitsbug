package service.member;

import dto.member.PaymentDTO;

public interface PaymentService {

    // 🔥 결제 생성 (READY 상태)
    PaymentDTO createPayment(PaymentDTO dto);

    // 🔥 결제 성공 처리
    void success(String orderId, String email);
    
    PaymentDTO getActivePayment(String email);

    // 취소 / 환불 요청
    void requestCancel(String orderId);
    void requestRefund(String orderId);
}