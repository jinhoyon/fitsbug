package dao.gym;

import org.apache.ibatis.session.SqlSession;

import dto.gym.TossPayment;
import util.MybatisSqlSessionFactory;

public class GymTossPaymentDaoImpl implements GymTossPaymentDao {

	@Override
	public void insertTossPayment(TossPayment tossPayment) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.tossPayment.insertTossPayment", tossPayment);
			session.commit();
		}

	}

	@Override
	public TossPayment selectTossPaymentByOrderId(String orderId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.tossPayment.selectTossPaymentByOrderId", orderId);

		}
	}

	@Override
	public void updateTossStatus(TossPayment tossPayment) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.update("mapper.tossPayment.updateTossStatus", tossPayment);
			session.commit();
		}

	}

	@Override
	public String selectPaymentKeyByOrderId(String orderId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			return session.selectOne("mapper.tossPayment.selectPaymentKeyByOrderId", orderId);
		}
	}

}
