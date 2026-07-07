package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.common.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.common.UserDTO;
import util.MybatisSqlSessionFactory;

public class GymSettingsDAOImpl implements GymSettingsDAO{

	@Override
	public Gym selectGymMypage(int gymId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.info_edit.selectGymMypage", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateGym(Gym gym) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.gym.info_edit.updateGym", gym);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public void updateGymUser(UserDTO user) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.gym.info_edit.updateGymUser", user);
	        sqlSession.commit();
	        
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updatePassword(Map<String, Object> param) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.gym.info_edit.updatePassword", param);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int countEmail(String emailId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.info_edit.countEmail", emailId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public Schedule selectSchedule(int gymId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.info_edit.selectSchedule", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateSchedule(Schedule schedule) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.gym.info_edit.updateSchedule", schedule);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<Membership> selectMembershipList(int gymId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.info_edit.selectMembershipList", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateMembership(Membership membership) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.gym.info_edit.updateMembership", membership);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int insertMembership(Membership membership) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.insert("mapper.gym.info_edit.insertMembership", membership);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int deleteMembership(int membershipNum) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.delete("mapper.gym.info_edit.deleteMembership", membershipNum);
	        sqlSession.commit();
	        return res;
		} catch (Exception e) {
		    sqlSession.rollback();
		    throw e;
		}finally{
			sqlSession.close();
		}
	}

	
}
