package service.member;

import dto.common.Payment;

public interface PaymentService {

    // 🔥 결제 생성 (READY 상태)
    Payment createPayment(Payment dto);

    // 🔥 결제 성공 처리
    void success(String orderId, String email);
    
    Payment getActivePayment(String email);

    // 취소 / 환불 요청
    void requestCancel(String orderId);
    void requestRefund(String orderId);
}