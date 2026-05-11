package dao.gym;

import dto.gym.TossPayment;

public interface GymTossPaymentDao {
	void insertTossPayment(TossPayment tossPayment);
    TossPayment selectTossPaymentByOrderId(String orderId);
    void updateTossStatus(TossPayment tossPayment);
    String selectPaymentKeyByOrderId(String orderId) throws Exception;
}
