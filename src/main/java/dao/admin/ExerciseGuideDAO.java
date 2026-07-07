package dao.admin;

import java.util.List;
import java.util.Map;

import dto.admin.ExerciseDTO;

public interface ExerciseGuideDAO {
	void insertGuide(ExerciseDTO dto) throws Exception;
	List<ExerciseDTO> selectAllGuide(Map<String, Object> paramMap) throws Exception;
	Integer selectGuideCount(Map<String, Object> paramMap) throws Exception;
	ExerciseDTO selectGuideById(int egNum) throws Exception;
	int updateExerciseGuide(ExerciseDTO dto) throws Exception;
	int deleteGuide(int egNum) throws Exception;
}
