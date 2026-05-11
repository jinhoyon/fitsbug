package dao.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.member.PostDTO;
import util.MybatisSqlSessionFactory;

public class PostDAOImpl implements PostDAO {

    @Override
    public int insert(PostDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = sqlSession.insert("mapper.PostMapper.insert", dto);
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
    public List<PostDTO> getList() {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<PostDTO> list = null;
        try {
            list = sqlSession.selectList("mapper.PostMapper.getList");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return list;
    }

    @Override
    public String getWriterEmail(int postId) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        String result = null;
        try {
            result = sqlSession.selectOne("mapper.PostMapper.getWriterEmail", postId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
}
