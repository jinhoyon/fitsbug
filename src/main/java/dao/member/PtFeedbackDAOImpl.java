package dao.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.member.PtFeedbackDTO;
import util.MybatisSqlSessionFactory;

public class PtFeedbackDAOImpl implements PtFeedbackDAO {

    @Override
    public List<PtFeedbackDTO> getFeedbackList(String email) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<PtFeedbackDTO> list = null;
        try {
            list = sqlSession.selectList("mapper.member.pt_feedback.getFeedbackList", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return list;
    }

    @Override
    public PtFeedbackDTO getFeedbackDetail(int id) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        PtFeedbackDTO result = null;
        try {
            result = sqlSession.selectOne("mapper.member.pt_feedback.getFeedbackDetail", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }

    @Override
    public void insertFeedback(PtFeedbackDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            sqlSession.insert("mapper.member.pt_feedback.insertFeedback", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }
}
