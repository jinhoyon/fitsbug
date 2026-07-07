package service.gym;

import java.util.List;

import dao.gym.GymReviewDAO;
import dao.gym.GymReviewDAOImpl;
import dto.gym.Review;

public class GymReviewServiceImpl implements GymReviewService {
	private GymReviewDAO dao = new GymReviewDAOImpl();
	
	@Override
	public void writeReview(Review review) throws Exception {
		dao.insertReview(review);
	}

	@Override
	public Review getReview(int reviewNum) throws Exception {
		return dao.selectReviewByReviewNum(reviewNum);
	}

	@Override
	public void updateReview(Review review, int loginUserId) throws Exception {
		Review origin = dao.selectReviewByReviewNum(review.getReviewNum());
		
		if(origin == null) throw new RuntimeException("리뷰가 존재하지 않습니다.");
		if(origin.getClientId() != loginUserId) throw new RuntimeException("본인 리뷰만 수정 가능합니다.");
		dao.updateReview(review);
	}

	@Override
	public void deleteReview(int reviewNum, int loginUserId) throws Exception {
		Review origin = dao.selectReviewByReviewNum(reviewNum);
		
		if(origin == null) throw new RuntimeException("리뷰가 존재하지 않습니다.");
		if(origin.getClientId() != loginUserId) throw new RuntimeException("본인 리뷰만 삭제 가능합니다.");
		dao.deleteReview(reviewNum);
	}

	@Override
	public List<Review> getReviewListByGymId(int gymId) throws Exception {
		return dao.selectReviewListByGymId(gymId);
	}

}
