package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.admin.ExerciseDTO;
import util.MybatisSqlSessionFactory;

public class ExerciseDAOImpl implements ExerciseDAO {

	@Override
	public void insertGuide(ExerciseDTO dto) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.admin.exercise.insertGuide", dto);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

	@Override
	public List<ExerciseDTO> selectAllGuide(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<ExerciseDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.exercise.selectAllGuide", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}
	
	@Override
	public Integer selectGuideCount(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		int cnt = 0;
		try {
			cnt = sqlSession.selectOne("mapper.admin.exercise.selectGuideCount", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return cnt;
	}

	@Override
	public ExerciseDTO selectGuideById(int egNum) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		ExerciseDTO dto = null;
		try {
			dto = sqlSession.selectOne("mapper.admin.exercise.selectGuideById", egNum);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return dto;
	}
	
	@Override
	public int updateExerciseGuide(ExerciseDTO dto) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    int result = 0;
	    try {
	        // 매퍼의 id("updateExerciseGuide")와 파라미터(dto) 전달
	        result = sqlSession.update("mapper.admin.exercise.updateExerciseGuide", dto);
	        sqlSession.commit(); // 실제 DB에 반영
	    } catch(Exception e) {
	        sqlSession.rollback();
	        e.printStackTrace();
	        throw e;
	    } finally {
	        sqlSession.close();
	    }
	    return result;
	}

	@Override
	public int deleteGuide(int egNum) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		int result = 0;
		try {
			result = sqlSession.delete("mapper.admin.exercise.deleteGuide", egNum);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return result;
	}
}