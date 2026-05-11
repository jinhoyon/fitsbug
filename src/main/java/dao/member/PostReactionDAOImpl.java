package dao.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import util.MybatisSqlSessionFactory;

public class PostReactionDAOImpl implements PostReactionDAO {

    @Override
    public int addReaction(int postId, String userId, String type) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("postId", postId);
            param.put("userId", userId);
            param.put("type",   type);
            result = sqlSession.insert("mapper.PostReactionMapper.addReaction", param);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    @Override
    public int getReactionCount(int postId, String type) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("postId", postId);
            param.put("type",   type);
            result = sqlSession.selectOne("mapper.PostReactionMapper.getReactionCount", param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> getAllCounts(int postId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<Map<String, Object>> result = null;
        try {
            result = sqlSession.selectList("mapper.PostReactionMapper.getAllCounts", postId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    @Override
    public int hasReacted(int postId, String userId, String type) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("postId", postId);
            param.put("userId", userId);
            param.put("type",   type);
            result = sqlSession.selectOne("mapper.PostReactionMapper.hasReacted", param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
}
