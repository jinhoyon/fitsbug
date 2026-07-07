package dao.gym;

import java.util.List;

import dto.gym.GymTrainerView;

public interface GymMainTrainerViewDAO {
	List<GymTrainerView> selectGymTrainerViewByGym(int gymId) throws Exception;
}
