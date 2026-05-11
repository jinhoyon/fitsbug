package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.member.InbodyLogDTO;
import util.MybatisSqlSessionFactory;
import java.util.List;

public class InbodyLogDAOImpl implements InbodyLogDAO {

    private static final String NS = "mapper.InbodyLogMapper.";

    @Override
    public int insert(InbodyLogDTO dto) {
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
    public List<InbodyLogDTO> findByMemberId(int memberId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<InbodyLogDTO> list = null;
        try {
            list = session.selectList(NS + "findByMemberId", memberId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public List<InbodyLogDTO> findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<InbodyLogDTO> list = null;
        try {
            list = session.selectList(NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }
}
