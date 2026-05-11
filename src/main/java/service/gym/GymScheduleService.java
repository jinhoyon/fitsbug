package service.gym;

import java.util.Map;

public interface GymScheduleService {
	Map<String, Object> getSchedulePageData(int gymId, int weekOffset) throws Exception;
}
