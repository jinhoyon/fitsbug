package dao.gym;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.gym.GymNotice;
import util.MybatisSqlSessionFactory;

public class GymMainNoticeDaoImpl implements GymMainNoticeDao {
	
	@Override
	public List<GymNotice> selectRecentNoticeByGym(int gymId) throws Exception {
		
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gymNotice.selectRecentNoticeByGym", gymId);
		}finally{
			sqlSession.close();
		}
	}

}
