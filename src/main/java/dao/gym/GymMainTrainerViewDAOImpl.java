package dao.gym;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.gym.GymTrainerView;
import util.MybatisSqlSessionFactory;

public class GymMainTrainerViewDAOImpl implements GymMainTrainerViewDAO {
	
	@Override
	public List<GymTrainerView> selectGymTrainerViewByGym(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gymTrainerView.selectTrainerViewByGym", gymId);
		}finally{
			sqlSession.close();
		}
	}

}
