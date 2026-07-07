package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.common.Payment;
import util.MybatisSqlSessionFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * PaymentDAOImpl - MyBatis 기반으로 전면 재작성
 * DB 컬럼: id, user_id, user_name, membership_id, mp_id, gym_id, trainer_id,
 *          payment_date, payment_price, payment_fee, method, status,
 *          payment_type, canceled_at, reason
 */
public class PaymentDAOImpl implements PaymentDAO {

    private static final String NS = "mapper.PaymentMapper.";

    @Override
    public int insert(Payment dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insert", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public void updateStatus(String orderId, String status) {
        // 레거시 호환: orderId 대신 id 기반으로 처리 (PaymentMapper의 updateStatus 사용)
        // 실제 사용 시 findById + updateStatus(map) 방식 권장
    }

    @Override
    public Payment findActiveByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        Payment result = null;
        try {
            // USER.email로 최근 결제 1건 조회 (하위 호환)
            List<Payment> list = session.selectList(NS + "findByUserId",
                    session.selectOne("mapper.UserMapper.findByEmail", email) != null
                    ? ((dto.common.UserDTO) session.selectOne("mapper.UserMapper.findByEmail", email)).getId()
                    : 0);
            if (list != null && !list.isEmpty()) result = list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public List<Payment> findByUserId(int userId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<Payment> list = null;
        try {
            list = session.selectList(NS + "findByUserId", userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public Payment findById(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        Payment result = null;
        try {
            result = session.selectOne(NS + "findById", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int cancel(Map<String, Object> params) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "cancel", params);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int requestRefund(Map<String, Object> params) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "requestRefund", params);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
}
