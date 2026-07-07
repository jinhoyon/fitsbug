package service.gym;

import dao.gym.GymTossPaymentDao;
import dao.gym.GymTossPaymentDaoImpl;
import dto.common.TossDTO;

public class GymTossPaymentServiceImpl implements GymTossPaymentService {
	private GymTossPaymentDao dao = new GymTossPaymentDaoImpl();
	@Override
	public void insertTossPayment(TossDTO tossPayment) {
		dao.insertTossPayment(tossPayment);

	}

	@Override
	public TossDTO selectTossPaymentByOrderId(String orderId) {
		return dao.selectTossPaymentByOrderId(orderId);
	}

	@Override
	public void updateTossStatus(TossDTO tossPayment) {
		dao.updateTossStatus(tossPayment);
	}

	@Override
	public String selectPaymentKeyByOrderId(String orderId) throws Exception {
		return dao.selectPaymentKeyByOrderId(orderId);
	}

}
