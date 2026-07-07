package dao.gym;

import org.apache.ibatis.session.SqlSession;

import dto.common.TossDTO;
import util.MybatisSqlSessionFactory;

public class GymTossPaymentDaoImpl implements GymTossPaymentDao {

	@Override
	public void insertTossPayment(TossDTO tossPayment) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.TossMapper.insert", tossPayment);
			session.commit();
		}

	}

	@Override
	public TossDTO selectTossPaymentByOrderId(String orderId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.TossMapper.findByOrderId", orderId);

		}
	}

	@Override
	public void updateTossStatus(TossDTO tossPayment) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			java.util.Map<String, Object> params = new java.util.HashMap<>();
			params.put("orderId", tossPayment.getOrderId());
			params.put("status", tossPayment.getStatus());
			session.update("mapper.TossMapper.updateStatus", params);
			session.commit();
		}
	}

	@Override
	public String selectPaymentKeyByOrderId(String orderId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.TossMapper.findPaymentKeyByOrderId", orderId);
		}
	}

}
