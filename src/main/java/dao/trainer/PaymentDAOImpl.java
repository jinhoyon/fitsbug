package dao.trainer;

import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class PaymentDAOImpl {
    public int insertPayment(PaymentDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = sqlSession.insert("mapper.trainerpayment.insertPayment", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    public PaymentDTO getPaymentByOrderId(String orderId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        PaymentDTO payment = null;
        try {
            payment = sqlSession.selectOne("mapper.trainerpayment.getPaymentByOrderId", orderId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return payment;
    }
}
