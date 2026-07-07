package dao.common;

import dto.common.Payment;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class PaymentDAOImpl implements PaymentDAO {

    private static final String NS = "mapper.PaymentMapper.";

    @Override
    public int insert(SqlSession session, Payment payment) {
        return session.insert(NS + "insert", payment);
    }

    @Override
    public Payment findById(SqlSession session, int id) {
        return session.selectOne(NS + "findById", id);
    }

    @Override
    public List<Payment> findByUserId(SqlSession session, int userId) {
        return session.selectList(NS + "findByUserId", userId);
    }

    @Override
    public int cancel(SqlSession session, Map<String, Object> params) {
        return session.update(NS + "cancel", params);
    }

    @Override
    public int requestRefund(SqlSession session, Map<String, Object> params) {
        return session.update(NS + "requestRefund", params);
    }
}
