package dao.gym;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.HotTime;
import dto.gym.MembershipDistribution;
import dto.gym.RevenueTrend;
import dto.gym.TodayPtSchedule;
import dto.gym.TopTrainerRevenue;
import dto.gym.WeeklyVisitStat;
import util.MybatisSqlSessionFactory;

public class GymDashboardDaoImpl implements GymDashboardDao {

	@Override
	public int selectNewMemberCount(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectNewMemberCount", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<TodayPtSchedule> selectTodayScheduleList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectTodayScheduleList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectTotalRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectTotalRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectMembershipRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectMembershipRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectPtRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectPtRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<TopTrainerRevenue> selectTopTrainerList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectTopTrainerList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<WeeklyVisitStat> selectWeeklyVisit(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectWeeklyVisit", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectNewMemberGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectNewMemberGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectTotalRevenueGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectTotalRevenueGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectMembershipGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectMembershipGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectPtGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.dashboard.selectPtGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<MembershipDistribution> selectMembershipDistributionList(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectMembershipDistributionList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<RevenueTrend> selectRevenueTrendList(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectRevenueTrendList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<HotTime> selectHotTimeList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.dashboard.selectHotTimeList", param);
		}finally{
			sqlSession.close();
		}
	}

}
