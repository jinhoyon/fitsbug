package dao.member;

import java.util.List;

import dto.member.ExerciseGuideDTO;

public interface ExerciseDAO {
    // 전체 조회
    List<ExerciseGuideDTO> getAllExercises();

    // 검색 (AJAX)
    List<ExerciseGuideDTO> searchExercises(String keyword);
}