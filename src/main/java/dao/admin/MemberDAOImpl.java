package dao.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.admin.MemberDTO;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

	@Override
	public List<MemberDTO> selectAllGym() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.member.selectAllGym");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}

	@Override
	public List<MemberDTO> selectAllTrainer() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.member.selectAllTrainer");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}

	@Override
	public List<MemberDTO> selectAllClient() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.member.selectAllClient");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}


	@Override
	public Integer selectGymCnt() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer gymCnt = 0;
		try {
			gymCnt = sqlSession.selectOne("mapper.admin.member.selectGymCnt");
		} catch(Exception e){
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return gymCnt;
	}

	@Override
	public Integer selectTrainerCnt() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer trainerCnt = 0;
		try {
			trainerCnt = sqlSession.selectOne("mapper.admin.member.selectTrainerCnt");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return trainerCnt;
	}

	@Override
	public Integer selectClientCnt() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer clientCnt = 0;
		try {
			clientCnt = sqlSession.selectOne("mapper.admin.member.selectClientCnt");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return clientCnt;
	}

	@Override
	public List<MemberDTO> selectGymList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> gymList = null;
		try {
			gymList = sqlSession.selectList("mapper.admin.member.selectGymList", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return gymList;
	}

	@Override
	public List<MemberDTO> selectTrainerList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> trainerList = null;
		try {
			trainerList = sqlSession.selectList("mapper.admin.member.selectTrainerList", paramMap);
			System.out.println("+++++++++++++++++");
			System.out.println(trainerList);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return trainerList;
	}

	@Override
	public List<MemberDTO> selectClientList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<MemberDTO> clientList = null;
		try {
			clientList = sqlSession.selectList("mapper.admin.member.selectClientList", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return clientList;
	}

	@Override
	public List<Map<String, Object>> selectAuthList() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<Map<String, Object>> authList = null;
		try {
			authList = sqlSession.selectList("mapper.admin.member.selectAuthList");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return authList;
	}


	@Override
	public Map<String, Object> selectGymAuthDetail(String userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> gymAuthDetail = null;
		try {
			gymAuthDetail = sqlSession.selectOne("mapper.admin.member.selectGymAuthDetail", userId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return gymAuthDetail;
	}

	@Override
	public Map<String, Object> selectTrainerAuthDetail(String userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> trainerAuthDetail = null;
		try {
			trainerAuthDetail = sqlSession.selectOne("mapper.admin.member.selectTrainerAuthDetail", userId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return trainerAuthDetail;
	}
	
	@Override
	public int updateGymStatus(String userId, String status) throws Exception {
	    SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true); // 자동 커밋
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("userId", userId);
	        map.put("status", status);
	        return sqlSession.update("mapper.admin.member.updateGymStatus", map);
	    } finally {
	        sqlSession.close();
	    }
	}

	@Override
	public int updateTrainerStatus(String userId, String status) throws Exception {
	    SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true);
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("userId", userId);
	        map.put("status", status);
	        return sqlSession.update("mapper.admin.member.updateTrainerStatus", map);
	    } finally {
	        sqlSession.close();
	    }
	}
}