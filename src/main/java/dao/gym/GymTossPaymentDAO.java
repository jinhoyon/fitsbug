package dao.gym;

import dto.common.TossDTO;

public interface GymTossPaymentDAO {
	void insertTossPayment(TossDTO tossPayment);
    TossDTO selectTossPaymentByOrderId(String orderId);
    void updateTossStatus(TossDTO tossPayment);
    String selectPaymentKeyByOrderId(String orderId) throws Exception;
}
