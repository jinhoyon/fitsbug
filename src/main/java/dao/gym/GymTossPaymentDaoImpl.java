package dao.gym;

import org.apache.ibatis.session.SqlSession;

import dto.common.TossDTO;
import util.MybatisSqlSessionFactory;

public class GymTossPaymentDaoImpl implements GymTossPaymentDao {

	@Override
	public void insertTossPayment(TossDTO tossPayment) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			session.insert("mapper.tossPayment.insertTossPayment", tossPayment);
			session.commit();
		}

	}

	@Override
	public TossDTO selectTossPaymentByOrderId(String orderId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.tossPayment.selectTossPaymentByOrderId", orderId);

		}
	}

	@Override
	public void updateTossStatus(TossDTO tossPayment) {
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
