package dao.trainer;

import dto.trainer.PaymentDTO;

public interface PaymentDAO {
    public int insertPayment(PaymentDTO dto);
    public PaymentDTO getPaymentByOrderId(String orderId);  // 추가
}
