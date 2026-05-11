package service.gym;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.GymDashboardDao;
import dao.gym.GymDashboardDaoImpl;
import dto.gym.Dashboard;
import dto.gym.WeeklyVisitStat;

public class GymDashboardServiceImpl implements GymDashboardService{
	private GymDashboardDao dao = new GymDashboardDaoImpl();
	@Override
	public Dashboard getDashboard(int gymId, String weekStart, String selectedDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
        param.put("gymId", gymId);

        LocalDate start;

        if (weekStart == null || weekStart.isEmpty()) {
            start = LocalDate.now().with(DayOfWeek.MONDAY);
        } else {
        	 LocalDate selectedWeek = LocalDate.parse(weekStart);
        	 start = selectedWeek.with(DayOfWeek.MONDAY);
        }
        
        LocalDate selected;

        if (selectedDate == null || selectedDate.isEmpty()) {
            selected = LocalDate.now();
        } else {
            selected = LocalDate.parse(selectedDate);
        }

        param.put("selectedDate", selected.toString());

        LocalDate end = start.plusDays(6);

        param.put("weekStart", start.toString());
        param.put("weekEnd", end.toString());
        
        Dashboard dashboard = new Dashboard();

        dashboard.setNewMemberCount(dao.selectNewMemberCount(param));
        dashboard.setTodayScheduleList(dao.selectTodayScheduleList(param));
        dashboard.setTotalRevenue(dao.selectTotalRevenue(param));
        dashboard.setMembershipRevenue(dao.selectMembershipRevenue(param));
        dashboard.setPtRevenue(dao.selectPtRevenue(param));
        dashboard.setTopTrainerList(dao.selectTopTrainerList(param));
        List<WeeklyVisitStat> weeklyVisitList = dao.selectWeeklyVisit(param);
        dashboard.setWeeklyVisitList(weeklyVisitList);
        dashboard.setNewMemberGrowthRate(dao.selectNewMemberGrowthRate(param));
        dashboard.setTotalRevenueGrowthRate(dao.selectTotalRevenueGrowthRate(param));
        dashboard.setMembershipGrowthRate(dao.selectMembershipGrowthRate(param));
        dashboard.setPtGrowthRate(dao.selectPtGrowthRate(param));
        dashboard.setMembershipDistributionList(dao.selectMembershipDistributionList(param));
        dashboard.setRevenueTrendList(dao.selectRevenueTrendList(param));
        dashboard.setTodayDate(selected.toString());
        dashboard.setWeekStart(start.toString());
        dashboard.setWeekEnd(end.toString());
        dashboard.setHotTimeList(dao.selectHotTimeList(param));
        
        return dashboard;
	}
	
}
