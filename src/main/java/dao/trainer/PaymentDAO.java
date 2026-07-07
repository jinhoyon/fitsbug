package dao.trainer;

import dto.common.TossDTO;
import org.apache.ibatis.session.SqlSession;

public interface PaymentDAO {
    int insertPayment(SqlSession session, TossDTO dto);

    TossDTO getPaymentByOrderId(SqlSession session, String orderId);
}
