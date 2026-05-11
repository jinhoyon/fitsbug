package service.gym;

import dto.gym.Dashboard;

public interface GymDashboardService {
	Dashboard getDashboard(int gymId, String weekStart, String selectedDate) throws Exception;
}
