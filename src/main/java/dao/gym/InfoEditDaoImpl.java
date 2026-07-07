package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.common.UserDTO;
import util.MybatisSqlSessionFactory;

public class InfoEditDaoImpl implements InfoEditDao{

	@Override
	public Gym selectGymMypage(int gymId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.infoEdit.selectGymMypage", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateGym(Gym gym) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.infoEdit.updateGym", gym);
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
			sqlSession.update("mapper.infoEdit.updateGymUser", user);
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
			int res = sqlSession.update("mapper.infoEdit.updatePassword", param);
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
			return sqlSession.selectOne("mapper.infoEdit.countEmail", emailId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public Schedule selectSchedule(int gymId) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.infoEdit.selectSchedule", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateSchedule(Schedule schedule) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.infoEdit.updateSchedule", schedule);
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
			return sqlSession.selectList("mapper.infoEdit.selectMembershipList", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int updateMembership(Membership membership) {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int res = sqlSession.update("mapper.infoEdit.updateMembership", membership);
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
			int res = sqlSession.insert("mapper.infoEdit.insertMembership", membership);
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
			int res = sqlSession.delete("mapper.infoEdit.deleteMembership", membershipNum);
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
