package service.trainer;

import dto.common.TossDTO;
import service.common.TossPaymentService;
import service.common.TossPaymentServiceImpl;

public class TrainerPaymentServiceImpl implements TrainerPaymentService {

    private final TossPaymentService tossPaymentService = new TossPaymentServiceImpl();

    @Override
    public TossDTO getPaymentByOrderId(String orderId) {
        return tossPaymentService.findByOrderId(orderId);
    }
}
