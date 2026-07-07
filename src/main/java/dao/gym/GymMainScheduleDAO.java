package dao.gym;

import dto.gym.Schedule;

public interface GymMainScheduleDAO {
	Schedule selectScheduleByGym(int gymNum) throws Exception;
}
