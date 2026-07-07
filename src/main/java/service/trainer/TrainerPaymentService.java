package service.trainer;

import dto.common.TossDTO;

public interface TrainerPaymentService {
    TossDTO getPaymentByOrderId(String orderId);
}
