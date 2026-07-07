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

public class DashboardDAOImpl implements DashboardDAO {

	@Override
	public int selectNewMemberCount(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectNewMemberCount", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<TodayPtSchedule> selectTodayScheduleList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectTodayScheduleList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectTotalRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectTotalRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectMembershipRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectMembershipRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public BigDecimal selectPtRevenue(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectPtRevenue", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<TopTrainerRevenue> selectTopTrainerList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectTopTrainerList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<WeeklyVisitStat> selectWeeklyVisit(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectWeeklyVisit", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectNewMemberGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectNewMemberGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectTotalRevenueGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectTotalRevenueGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectMembershipGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectMembershipGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public double selectPtGrowthRate(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.dashboard.selectPtGrowthRate", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<MembershipDistribution> selectMembershipDistributionList(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectMembershipDistributionList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<RevenueTrend> selectRevenueTrendList(Map<String, Object> param) throws Exception{
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectRevenueTrendList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<HotTime> selectHotTimeList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.dashboard.selectHotTimeList", param);
		}finally{
			sqlSession.close();
		}
	}

}
