package dao.trainer;

import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;

public class PaymentDAOImpl implements PaymentDAO {

    @Override
    public int insertPayment(SqlSession session, PaymentDTO dto) {
        return session.insert("mapper.trainerpayment.insertPayment", dto);
    }

    @Override
    public PaymentDTO getPaymentByOrderId(SqlSession session, String orderId) {
        return session.selectOne("mapper.trainerpayment.getPaymentByOrderId", orderId);
    }
}
