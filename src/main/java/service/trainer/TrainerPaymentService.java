package service.trainer;

import dto.trainer.PaymentDTO;

public interface TrainerPaymentService {
    PaymentDTO getPaymentByOrderId(String orderId);
}
