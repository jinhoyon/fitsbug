package service.member;

import java.util.List;

import dto.member.ExerciseGuideDTO;

public interface ExerciseService {
    List<ExerciseGuideDTO> getAllExercises();

    List<ExerciseGuideDTO> searchExercises(String keyword);
}