package dao.admin;

import org.apache.ibatis.session.SqlSession;

import dto.admin.AdminMainDTO;
import util.MybatisSqlSessionFactory;

public class AdminMainDAOImpl implements AdminMainDAO {

	@Override
	public AdminMainDTO getDashboardStats() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		AdminMainDTO stats = null;
		try {
			stats = sqlSession.selectOne("mapper.admin.adminMain.getDashboardStats");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return stats;
	}
}
