package service.gym;

import dto.gym.TossPayment;

public interface GymTossPaymentService {
	void insertTossPayment(TossPayment tossPayment);
    TossPayment selectTossPaymentByOrderId(String orderId);
    void updateTossStatus(TossPayment tossPayment);
    String selectPaymentKeyByOrderId(String orderId) throws Exception;
}
