package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.PtSessionView;
import dto.gym.TrainerChoose;
import util.MybatisSqlSessionFactory;

public class GymScheduleDAOImpl implements GymScheduleDAO{
	
	@Override
	public List<TrainerChoose> selectTrainerListByGym(int gymId) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.schedule.selectTrainerListByGym", gymId);
		}finally {
			session.close();
		}
	}

	@Override
	public List<PtSessionView> selectPtSessionListByGymAndWeek(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.schedule.selectPtSessionListByGymAndWeek", param);
		}finally {
			session.close();
		}
	}
	
}
