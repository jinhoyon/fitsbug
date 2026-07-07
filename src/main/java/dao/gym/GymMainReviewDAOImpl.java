package dao.gym;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.gym.Review;
import util.MybatisSqlSessionFactory;

public class GymMainReviewDAOImpl implements GymMainReviewDAO {

	@Override
	public List<Review> selectRecentReviewByGym(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.review.selectRecentReviewByGym", gymId);
		}finally{
			sqlSession.close();
		}
	}
	
}
