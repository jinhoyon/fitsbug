package dao.gym;

import java.util.List;

import dto.gym.GymTrainerView;

public interface TrainerViewDAO {
	List<GymTrainerView> selectGymTrainerViewByGym(int gymId) throws Exception;
}
