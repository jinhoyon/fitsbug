package dao.member;

import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;
import java.util.List;

public class CompleteDAOImpl implements CompleteDAO {

    @Override
    public void insertLog(String userId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            sqlSession.insert("mapper.CompleteMapper.insertLog", userId);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }

    @Override
    public List<String> getWeekLog(String userId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<String> list = null;
        try {
            list = sqlSession.selectList("mapper.CompleteMapper.getWeekLog", userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return list;
    }

    @Override
    public int getStreak(String userId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = sqlSession.selectOne("mapper.CompleteMapper.getStreak", userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    @Override
    public int getBestStreak(String userId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = sqlSession.selectOne("mapper.CompleteMapper.getBestStreak", userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
}
