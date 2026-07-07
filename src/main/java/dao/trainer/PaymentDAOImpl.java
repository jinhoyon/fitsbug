package dao.trainer;

import dto.common.TossDTO;
import org.apache.ibatis.session.SqlSession;

public class PaymentDAOImpl implements PaymentDAO {

    @Override
    public int insertPayment(SqlSession session, TossDTO dto) {
        return session.insert("mapper.trainerpayment.insertPayment", dto);
    }

    @Override
    public TossDTO getPaymentByOrderId(SqlSession session, String orderId) {
        return session.selectOne("mapper.trainerpayment.getPaymentByOrderId", orderId);
    }
}
