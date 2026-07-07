package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.PtSessionView;
import dto.gym.TrainerChoose;

public interface GymScheduleDao {
	List<TrainerChoose> selectTrainerListByGym(int gymId) throws Exception;
    List<PtSessionView> selectPtSessionListByGymAndWeek(Map<String, Object> param) throws Exception;
}
