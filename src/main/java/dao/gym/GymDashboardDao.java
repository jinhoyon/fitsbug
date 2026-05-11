package dao.gym;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import dto.gym.HotTime;
import dto.gym.MembershipDistribution;
import dto.gym.RevenueTrend;
import dto.gym.TodayPtSchedule;
import dto.gym.TopTrainerRevenue;
import dto.gym.WeeklyVisitStat;

public interface GymDashboardDao {
	int selectNewMemberCount(Map<String, Object> param) throws Exception;
    List<TodayPtSchedule> selectTodayScheduleList(Map<String, Object> param) throws Exception;
    BigDecimal selectTotalRevenue(Map<String, Object> param) throws Exception;
    BigDecimal selectMembershipRevenue(Map<String, Object> param) throws Exception;
    BigDecimal selectPtRevenue(Map<String, Object> param) throws Exception;
    List<TopTrainerRevenue> selectTopTrainerList(Map<String, Object> param) throws Exception;
    List<WeeklyVisitStat> selectWeeklyVisit(Map<String, Object> param) throws Exception;
    double selectNewMemberGrowthRate(Map<String, Object> param)throws Exception;
    double selectTotalRevenueGrowthRate(Map<String, Object> param)throws Exception;
    double selectMembershipGrowthRate(Map<String, Object> param)throws Exception;
    double selectPtGrowthRate(Map<String, Object> param)throws Exception;
    List<MembershipDistribution> selectMembershipDistributionList(Map<String, Object> param)throws Exception;
    List<RevenueTrend> selectRevenueTrendList(Map<String, Object> param)throws Exception;
    List<HotTime> selectHotTimeList(Map<String, Object> param) throws Exception;
}
