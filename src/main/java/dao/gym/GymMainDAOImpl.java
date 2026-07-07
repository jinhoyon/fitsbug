package dao.gym;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.common.Gym;
import dto.gym.HotTime;
import dto.common.UserDTO;
import util.MybatisSqlSessionFactory;

public class GymMainDaoImpl implements GymMainDao {
	
	@Override
	public Map<String,Object> selectGymMainInfo(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gymMain.selectGymMainInfo", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public HotTime selectTodayHotTime(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gymMain.selectTodayHotTime", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public void insertGym(Gym gym) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.gymMain.insertGym", gym);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertUserByGym(UserDTO user) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.gymMain.insertUserByGym", user);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Gym selectGymByUserId(Integer userId) {
		Gym gym = null;
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			gym = sqlSession.selectOne("mapper.gymMain.selectGymByUserId", userId);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return gym;
	}

}
