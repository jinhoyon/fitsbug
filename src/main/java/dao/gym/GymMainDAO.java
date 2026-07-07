package dao.gym;

import java.util.Map;

import dto.common.Gym;
import dto.gym.HotTime;
import dto.common.UserDTO;

public interface GymMainDao {
	Map<String,Object> selectGymMainInfo(int gymId) throws Exception;
	HotTime selectTodayHotTime(Map<String, Object> param) throws Exception;
	void insertGym(Gym gym) throws Exception;
	void insertUserByGym(UserDTO user) throws Exception;
	Gym selectGymByUserId(Integer userId) throws Exception;
}
