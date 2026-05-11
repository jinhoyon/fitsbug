package dao.gym;

import java.util.List;

import dto.gym.Review;

public interface GymMainReviewDao {
	List<Review> selectRecentReviewByGym(int gymId) throws Exception;
}
