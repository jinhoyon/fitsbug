package dao.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.common.Payment;
import util.MybatisSqlSessionFactory;

public class GymPaymentDaoImpl implements GymPaymentDao {

	@Override
	public int insertMembershipRegistration(MembershipRegistration membershipRegistration) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int result = session.insert("mapper.payment.insertMembershipRegistration", membershipRegistration);
			session.commit();
			return result;
		} catch (Exception e) {
			session.rollback();
			throw e;

		} finally {
			session.close();
		}
	}

	@Override
	public int insertPayment(Payment payment) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int result = session.insert("mapper.payment.insertPayment", payment);
			session.commit();
			return result;
		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
	}

	@Override
	public MembershipRegistration selectMembershipRegistration(int mrNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.payment.selectMembershipRegistration", mrNum);
		} finally {
			session.close();
		}
	}

	@Override
	public Payment selectPayment(int paymentNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.payment.selectPayment", paymentNum);
		} finally {
			session.close();
		}
	}

	@Override
	public Membership selectMembership(int membershipNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.payment.selectMembership", membershipNum);
		} finally {
			session.close();
		}
	}

	@Override
	public List<Payment> selectRefundRequestList(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.payment.selectRefundRequestList", gymId);
		} finally {
			session.close();
		}
	}

	@Override
	public int countRefundRequest(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.payment.countRefundRequest", gymId);
		} finally {
			session.close();
		}
	}

	@Override
	public void approveRefund(int paymentNum, int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			Map<String, Object> param = new HashMap<>();
			param.put("paymentNum", paymentNum);
			param.put("gymId", gymId);

			session.update("mapper.payment.approveRefund", param);
			session.commit();

		} catch (Exception e) {
			session.rollback();
			throw e;

		} finally {
			session.close();
		}
	}

	@Override
	public List<Payment> selectCancelRequestList(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.payment.selectCancelRequestList", param);
		} finally {
			session.close();
		}
	}

	@Override
	public int countCancelRequest(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.payment.countCancelRequest", gymId);
		} finally {
			session.close();
		}
	}

	@Override
	public void updateCancelApprove(int paymentNum, int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			Map<String, Object> param = new HashMap<>();
			param.put("paymentNum", paymentNum);
			param.put("gymId", gymId);

			session.update("mapper.payment.updateCancelApprove", param);
			session.commit();

		} catch (Exception e) {
			session.rollback();
			throw e;

		} finally {
			session.close();
		}
	}

	@Override
	public void cancelPtSessionByPayment(int paymentNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			session.update("mapper.payment.cancelPtSessionByPayment", paymentNum);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}

	}

	@Override
	public int registerMembershipAndPayment(MembershipRegistration membershipRegistration, Payment payment)
			throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

		try {
			int mrResult = session.insert("mapper.payment.insertMembershipRegistration", membershipRegistration);

			payment.setMrNum(membershipRegistration.getMrNum());

			int paymentResult = session.insert("mapper.payment.insertPayment", payment);

			session.commit();

			return mrResult + paymentResult;

		} catch (Exception e) {
			session.rollback();
			throw e;

		} finally {
			session.close();
		}
	}

	@Override
	public Payment selectPaymentByOrderId(String orderId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectOne("mapper.payment.selectPaymentByOrderId", orderId);
		}
	}

	@Override
	public int cancelPaymentByOrderId(String orderId, String reason) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("orderId", orderId);
			param.put("reason", reason);

			int result = session.update("mapper.payment.cancelPaymentByOrderId", param);
			session.commit();
			return result;
		}
	}

	@Override
	public void expireMembershipPtByOrderId(String orderId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			session.update("mapper.payment.expireMembershipPtByOrderId", orderId);
			session.commit();
		} catch (Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}

	}

}
