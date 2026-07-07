package dao.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.member.CommentDTO;
import util.MybatisSqlSessionFactory;

public class CommentDAOImpl implements CommentDAO {

    @Override
    public void insert(CommentDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            sqlSession.insert("mapper.member.comment.insert", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }

    @Override
    public List<CommentDTO> findByPostNum(int postNum) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<CommentDTO> list = null;
        try {
            list = sqlSession.selectList("mapper.member.comment.findByPostNum", postNum);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return list;
    }
}
