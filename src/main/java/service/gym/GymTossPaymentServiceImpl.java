package service.gym;

import dto.common.TossDTO;
import service.common.TossPaymentService;
import service.common.TossPaymentServiceImpl;

public class GymTossPaymentServiceImpl implements GymTossPaymentService {

    private final TossPaymentService tossPaymentService = new TossPaymentServiceImpl();

    @Override
    public void insertTossPayment(TossDTO tossPayment) {
        tossPaymentService.saveToss(tossPayment);
    }

    @Override
    public TossDTO selectTossPaymentByOrderId(String orderId) {
        return tossPaymentService.findByOrderId(orderId);
    }

    @Override
    public void updateTossStatus(TossDTO tossPayment) {
        tossPaymentService.updateStatus(tossPayment.getOrderId(), tossPayment.getStatus());
    }

    @Override
    public String selectPaymentKeyByOrderId(String orderId) throws Exception {
        return tossPaymentService.getPaymentKeyByOrderId(orderId);
    }
}
