package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.MemberManage;
import util.MybatisSqlSessionFactory;

public class MemberManageDAOImpl implements MemberManageDAO {

	@Override
	public List<MemberManage> selectMemberList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gym.member_manage.selectMemberList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int countMember(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.member_manage.countMember", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int countNewMember(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.member_manage.countNewMember", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public int countMemberList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gym.member_manage.countMemberList", param);
		}finally{
			sqlSession.close();
		}
	}

}
