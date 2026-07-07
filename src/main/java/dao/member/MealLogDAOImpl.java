package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.member.MealLogDTO;
import util.MybatisSqlSessionFactory;
import java.util.List;

public class MealLogDAOImpl implements MealLogDAO {

    private static final String NS = "mapper.member.meal_log.";

    @Override
    public int insert(MealLogDTO dto) {
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
    public List<MealLogDTO> findByMemberId(int memberId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<MealLogDTO> list = null;
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
    public List<MealLogDTO> findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<MealLogDTO> list = null;
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
