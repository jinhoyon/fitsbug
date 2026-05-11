package service.member;

import dao.member.TrainerReviewDAO;
import dao.member.TrainerReviewDAOImpl;
import dto.member.TrainerReviewDTO;

public class TrainerReviewServiceImpl implements TrainerReviewService {
    private TrainerReviewDAO dao = new TrainerReviewDAOImpl();

    @Override
    public int writeReview(TrainerReviewDTO dto) {
        return dao.insert(dto);
    }
}