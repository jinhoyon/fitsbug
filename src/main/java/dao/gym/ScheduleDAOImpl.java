package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.PtSessionView;
import dto.gym.Schedule;
import dto.gym.TrainerChoose;
import util.MybatisSqlSessionFactory;

public class ScheduleDAOImpl implements ScheduleDAO{
	
	@Override
	public List<TrainerChoose> selectTrainerListByGym(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.gym.schedule.selectTrainerListByGym", gymId);
		}finally {
			session.close();
		}
	}

	@Override
	public List<PtSessionView> selectPtSessionListByGymAndWeek(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.gym.schedule.selectPtSessionListByGymAndWeek", param);
		}finally {
			session.close();
		}
	}
	

	@Override
	public Schedule selectScheduleByGym(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.schedule.selectScheduleByGym", gymId);
		} finally {
			sqlSession.close();
		}
	}

}
