package dao.member;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.member.MemberDTO;
import dto.member.UserDTO;
import util.MybatisSqlSessionFactory;

/**
 * ✅ WorkoutPlanDTO/WorkoutPlanMapper 참조 완전 제거
 *    → MemberMapper 로 통합
 */
public class MyPageDAOImpl implements MyPageDAO {

    private static final String USER_NS   = "mapper.UserMapper.";
    private static final String MEMBER_NS = "mapper.MemberMapper.";

    /** USER 테이블 조회 */
    @Override
    public UserDTO selectUser(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        UserDTO result = null;
        try {
            result = session.selectOne(USER_NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    /**
     * MEMBER 테이블 조회 (회원 정보 + 운동 계획 통합)
     * ✅ WorkoutPlanMapper.getPlan → MemberMapper.findByEmail 로 교체
     */
    @Override
    public Map<String, Object> selectMember(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        Map<String, Object> result = null;
        try {
            result = session.selectOne(MEMBER_NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    /** USER 기본 정보 수정 */
    @Override
    public void updateUser(UserDTO user) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            session.update(USER_NS + "update", user);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    /**
     * MEMBER 운동 계획 수정 (height, weight, diet, goals, experience)
     * ✅ WorkoutPlanMapper.update → MemberMapper.updatePlan 으로 교체
     */
    @Override
    public void updateMemberPlan(MemberDTO member) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            session.update(MEMBER_NS + "updatePlan", member);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    /** 프로필 이미지 수정 */
    @Override
    public void updateProfileImg(UserDTO user) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            session.update(MEMBER_NS + "updateProfileImage", user);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
