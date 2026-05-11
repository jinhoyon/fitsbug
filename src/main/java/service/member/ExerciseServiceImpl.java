package service.member;

import java.util.List;

import dao.member.ExerciseDAO;
import dao.member.ExerciseDAOImpl;
import dto.member.ExerciseGuideDTO;

public class ExerciseServiceImpl implements ExerciseService {
    private ExerciseDAO dao = new ExerciseDAOImpl();

    @Override
    public List<ExerciseGuideDTO> getAllExercises() {
        return dao.getAllExercises();
    }

    @Override
    public List<ExerciseGuideDTO> searchExercises(String keyword) {
        return dao.searchExercises(keyword);
    }
}