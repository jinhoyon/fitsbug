package dao.common;

import dto.common.Payment;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public interface PaymentDAO {

    int insert(SqlSession session, Payment payment);

    Payment findById(SqlSession session, int id);

    List<Payment> findByUserId(SqlSession session, int userId);

    int cancel(SqlSession session, Map<String, Object> params);

    int requestRefund(SqlSession session, Map<String, Object> params);
}
