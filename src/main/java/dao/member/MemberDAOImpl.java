package dao.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.member.MemberDTO;
import util.MybatisSqlSessionFactory;

public class MemberDAOImpl implements MemberDAO {

    private static final String NS = "mapper.member.member.";

    @Override
    public int insertMember(MemberDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insertMember", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public MemberDTO findByUserId(int userId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        MemberDTO result = null;
        try {
            result = session.selectOne(NS + "findByUserId", userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public MemberDTO findById(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        MemberDTO result = null;
        try {
            result = session.selectOne(NS + "findById", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public Map<String,Object> findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        Map<String,Object> result = null;
        try {
            result = session.selectOne(NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }


    @Override
    public int update(MemberDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.update(NS + "update", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public List<MemberDTO> findByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<MemberDTO> list = null;
        try {
            list = session.selectList(NS + "findByTrainerId", trainerId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public List<MemberDTO> findByGymId(int gymId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<MemberDTO> list = null;
        try {
            list = session.selectList(NS + "findByGymId", gymId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

	@Override
	public MemberDTO selectMemberByUserId(Integer userId) throws Exception {
		System.out.println(userId);
		MemberDTO memberDto = null;
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

			memberDto = sqlSession.selectOne("mapper.member.member.selectMemberByUserIdUsingLogin", userId);
		}
		return memberDto;
	}
}