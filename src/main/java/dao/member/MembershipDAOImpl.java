package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.member.MembershipDTO;
import dto.member.MembershipRegistrationDTO;
import util.MybatisSqlSessionFactory;
import java.util.List;
import java.util.Map;

/**
 * MembershipDAOImpl - MyBatis 기반으로 재작성
 * MEMBERSHIP_PT 테이블 참조 (기존 MEMBERSHIP_REGISTRATION → MEMBERSHIP_PT)
 */
public class MembershipDAOImpl implements MembershipDAO {

    private static final String NS = "mapper.MembershipMapper.";

    /** @deprecated 레거시 호환용 stub */
    @Override
    public void decreaseCount(String email) {
        // MEMBERSHIP_PT.lesson_count 기반으로 처리됨
        // 사용 금지: decrementLessonCount(int mpId) 를 사용하세요
    }

    @Override
    public MembershipDTO findById(int id) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectOne(NS + "findById", id); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }

    @Override
    public List<MembershipDTO> findByGymId(int gymId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectList(NS + "findByGymId", gymId); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }

    @Override
    public List<MembershipDTO> findByTrainerId(int trainerId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectList(NS + "findByTrainerId", trainerId); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }

    @Override
    public int insertRegistration(MembershipRegistrationDTO dto) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = s.insert(NS + "insertRegistration", dto);
            s.commit();
        } catch (Exception e) { s.rollback(); e.printStackTrace(); }
        finally { s.close(); }
        return result;
    }

    @Override
    public List<MembershipRegistrationDTO> findRegistrationByMemberId(int memberId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectList(NS + "findRegistrationByMemberId", memberId); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }

    @Override
    public MembershipRegistrationDTO findActiveByMemberId(int memberId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectOne(NS + "findActiveByMemberId", memberId); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }

    @Override
    public int updateRegistrationStatus(Map<String, Object> params) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = s.update(NS + "updateRegistrationStatus", params);
            s.commit();
        } catch (Exception e) { s.rollback(); e.printStackTrace(); }
        finally { s.close(); }
        return result;
    }

    @Override
    public int decrementLessonCount(int mpId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = s.update(NS + "decrementLessonCount", mpId);
            s.commit();
        } catch (Exception e) { s.rollback(); e.printStackTrace(); }
        finally { s.close(); }
        return result;
    }

    @Override
    public int addLessonCount(Map<String, Object> params) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = s.update(NS + "addLessonCount", params);
            s.commit();
        } catch (Exception e) { s.rollback(); e.printStackTrace(); }
        finally { s.close(); }
        return result;
    }

    @Override
    public List<MembershipRegistrationDTO> findRegistrationByTrainerId(int trainerId) {
        SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try { return s.selectList(NS + "findRegistrationByTrainerId", trainerId); }
        catch (Exception e) { e.printStackTrace(); return null; }
        finally { s.close(); }
    }
}
