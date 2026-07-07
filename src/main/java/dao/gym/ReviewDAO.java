package dao.gym;

import java.util.List;

import dto.gym.Review;

public interface ReviewDAO {
	void insertReview(Review review) throws Exception;
	Review selectReviewByReviewNum(int reviewNum) throws Exception;
	void updateReview(Review review) throws Exception;
	void deleteReview(int reviewNum) throws Exception;
	List<Review> selectReviewListByGymId(int gymId) throws Exception;
	List<Review> selectRecentReviewByGym(int gymId) throws Exception;
}
