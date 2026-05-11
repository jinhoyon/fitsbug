package service.gym;

import dao.gym.GymTossPaymentDao;
import dao.gym.GymTossPaymentDaoImpl;
import dto.gym.TossPayment;

public class GymTossPaymentServiceImpl implements GymTossPaymentService {
	private GymTossPaymentDao dao = new GymTossPaymentDaoImpl();
	@Override
	public void insertTossPayment(TossPayment tossPayment) {
		dao.insertTossPayment(tossPayment);

	}

	@Override
	public TossPayment selectTossPaymentByOrderId(String orderId) {
		return dao.selectTossPaymentByOrderId(orderId);
	}

	@Override
	public void updateTossStatus(TossPayment tossPayment) {
		dao.updateTossStatus(tossPayment);
	}

	@Override
	public String selectPaymentKeyByOrderId(String orderId) throws Exception {
		return dao.selectPaymentKeyByOrderId(orderId);
	}

}
