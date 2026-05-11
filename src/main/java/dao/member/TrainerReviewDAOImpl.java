package dao.member;

import org.apache.ibatis.session.SqlSession;

import dto.member.TrainerReviewDTO;
import util.MybatisSqlSessionFactory;

public class TrainerReviewDAOImpl implements TrainerReviewDAO {

    @Override
    public int insert(TrainerReviewDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = sqlSession.insert("mapper.TrainerReviewMapper.insert", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
}
