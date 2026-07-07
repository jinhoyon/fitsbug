package dao.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.TrainerAssign;
import dto.gym.TrainerList;
import dto.gym.TrainerMemberView;
import util.MybatisSqlSessionFactory;

public class TrainerManageDAOImpl implements TrainerManageDAO {

	@Override
	public List<TrainerMemberView> selectCurrentMembers(int trainerId, int gymId) throws Exception{
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        Map<String, Object> param = new HashMap<>();
	        param.put("trainerId", trainerId);
	        param.put("gymId", gymId);

	        return session.selectList("mapper.trainerManage.selectCurrentMembers", param);
	    } finally {
	        session.close();
	    }
	}

	@Override
	public List<TrainerMemberView> selectPastMembers(int trainerId, int gymId) throws Exception{
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        Map<String, Object> param = new HashMap<>();
	        param.put("trainerId", trainerId);
	        param.put("gymId", gymId);

	        return session.selectList("mapper.trainerManage.selectPastMembers", param);
	    } finally {
	        session.close();
	    }
	}

	@Override
	public List<TrainerList> selectTrainerList(Map<String, Object> param) throws Exception{
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.trainerManage.selectTrainerList", param);
		}finally {
			session.close();
		}
	}

	@Override
	public List<TrainerAssign> selectTrainerAssignList(int gymId) throws Exception{
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.trainerManage.selectTrainerAssignList", gymId);
		}finally {
			session.close();
		}
	}

}
