package service.gym;

import java.util.List;

import dto.gym.Review;

public interface GymReviewService {
	void writeReview(Review review) throws Exception;
	Review getReview(int reviewNum) throws Exception;
	void updateReview(Review review, int loginUserId) throws Exception;
	void deleteReview(int reviewNum, int loginUserId) throws Exception;
	List<Review> getReviewListByGymId(int gymId) throws Exception;
}
