package dao.common;

import dto.common.TossDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class TossDAOImpl implements TossDAO {

    private static final String NS = "mapper.member.toss.";

    @Override
    public int insert(SqlSession session, TossDTO dto) {
        return session.insert(NS + "insert", dto);
    }

    @Override
    public TossDTO findByOrderId(SqlSession session, String orderId) {
        return session.selectOne(NS + "findByOrderId", orderId);
    }

    @Override
    public int updateStatus(SqlSession session, String orderId, String status) {
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("status", status);
        return session.update(NS + "updateStatus", params);
    }

    @Override
    public String findPaymentKeyByOrderId(SqlSession session, String orderId) {
        return session.selectOne(NS + "findPaymentKeyByOrderId", orderId);
    }
}
