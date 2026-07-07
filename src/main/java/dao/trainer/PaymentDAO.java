package dao.trainer;

import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;

public interface PaymentDAO {
    int insertPayment(SqlSession session, PaymentDTO dto);

    PaymentDTO getPaymentByOrderId(SqlSession session, String orderId);
}
