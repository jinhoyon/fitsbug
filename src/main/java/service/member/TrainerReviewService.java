package service.member;

import dto.member.TrainerReviewDTO;

public interface TrainerReviewService {
    int writeReview(TrainerReviewDTO dto);
}