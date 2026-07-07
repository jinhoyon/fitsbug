package service.common;

import dao.common.PaymentDAO;
import dao.common.PaymentDAOImpl;
import dto.common.Payment;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.Collections;
import java.util.List;

public class PaymentServiceImpl implements PaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAOImpl();

    @Override
    public Payment insert(Payment payment) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            paymentDAO.insert(session, payment);
            session.commit();
            return payment;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public Payment findById(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return paymentDAO.findById(session, id);
        } finally {
            session.close();
        }
    }

    @Override
    public List<Payment> findByUserId(int userId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            List<Payment> list = paymentDAO.findByUserId(session, userId);
            return list != null ? list : Collections.emptyList();
        } finally {
            session.close();
        }
    }

    @Override
    public int cancel(int paymentId, String reason) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            java.util.Map<String, Object> params = new java.util.HashMap<>();
            params.put("id", paymentId);
            params.put("reason", reason);
            int result = paymentDAO.cancel(session, params);
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
    public int requestRefund(int paymentId, String reason) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            java.util.Map<String, Object> params = new java.util.HashMap<>();
            params.put("id", paymentId);
            params.put("reason", reason);
            int result = paymentDAO.requestRefund(session, params);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
