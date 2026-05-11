package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.member.NotificationDTO;
import util.MybatisSqlSessionFactory;
import java.util.List;

public class NotificationDAOImpl implements NotificationDAO {

    private static final String NS = "mapper.NotificationMapper.";

    @Override
    public List<NotificationDTO> findByRecvId(String recvId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<NotificationDTO> list = null;
        try {
            list = session.selectList(NS + "findByRecvId", recvId);
        } catch (Exception e) { e.printStackTrace(); }
        finally { session.close(); }
        return list;
    }

    @Override
    public int countUnread(String recvId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.selectOne(NS + "countUnread", recvId);
        } catch (Exception e) { e.printStackTrace(); }
        finally { session.close(); }
        return result;
    }

    @Override
    public int insert(NotificationDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insert", dto);
            session.commit();
        } catch (Exception e) { session.rollback(); e.printStackTrace(); }
        finally { session.close(); }
        return result;
    }

    @Override
    public int updateReadAll(String recvId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "updateReadAll", recvId);
            session.commit();
        } catch (Exception e) { session.rollback(); e.printStackTrace(); }
        finally { session.close(); }
        return result;
    }

    @Override
    public int updateReadOne(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "updateReadOne", id);
            session.commit();
        } catch (Exception e) { session.rollback(); e.printStackTrace(); }
        finally { session.close(); }
        return result;
    }
}
