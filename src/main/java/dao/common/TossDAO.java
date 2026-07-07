package dao.common;

import dto.common.TossDTO;
import org.apache.ibatis.session.SqlSession;

public interface TossDAO {

    int insert(SqlSession session, TossDTO dto);

    TossDTO findByOrderId(SqlSession session, String orderId);

    int updateStatus(SqlSession session, String orderId, String status);

    String findPaymentKeyByOrderId(SqlSession session, String orderId);
}
