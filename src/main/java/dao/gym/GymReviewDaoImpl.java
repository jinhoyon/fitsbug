package dao.gym;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.gym.Review;
import util.MybatisSqlSessionFactory;

public class GymReviewDaoImpl implements GymReviewDao {

	@Override
	public void insertReview(Review review) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			session.insert("mapper.review.insertReview",review);
			session.commit();
		} catch (Exception e) {
		    session.rollback();
		    throw e;
		}finally {
			session.close();
		}
	}

	@Override
	public Review selectReviewByReviewNum(int reviewNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.review.selectReviewByReviewNum", reviewNum);
		}finally {
			session.close();
		}
	}

	@Override
	public void updateReview(Review review) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			session.update("mapper.review.updateReview",review);
			session.commit();
		} catch (Exception e) {
		    session.rollback();
		    throw e;
		}finally {
			session.close();
		}
	}

	@Override
	public void deleteReview(int reviewNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			session.delete("mapper.review.deleteReview",reviewNum);
			session.commit();
		} catch (Exception e) {
		    session.rollback();
		    throw e;
		}finally {
			session.close();
		}

	}

	@Override
	public List<Review> selectReviewListByGymId(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.review.selectReviewListByGymId", gymId);
		}finally {
			session.close();
		}
	}

}
