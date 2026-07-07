package dao.member;

import org.apache.ibatis.session.SqlSession;
import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import util.MybatisSqlSessionFactory;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkoutLogDAOImpl implements WorkoutLogDAO {

    private static final String NS = "mapper.member.workout_log.";

    @Override
    public int insert(WorkoutLogDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insert", dto);
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
    public int insertWithDetails(WorkoutLogDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            result = session.insert(NS + "insert", dto);
            if (result > 0 && dto.getDetails() != null) {
                for (WorkoutDetailDTO detail : dto.getDetails()) {
                    detail.setWorkoutId(dto.getId());
                    session.insert(NS + "insertDetail", detail);
                }
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            result = 0;
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public List<WorkoutLogDTO> findByMemberId(int memberId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<WorkoutLogDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findByMemberId", memberId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public List<WorkoutLogDTO> findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<WorkoutLogDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public List<WorkoutLogDTO> findTodayByMemberId(int memberId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<WorkoutLogDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findTodayByMemberId", memberId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    @Override
    public WorkoutLogDTO findTodayLog(int memberId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        WorkoutLogDTO result = null;
        try {
            result = session.selectOne(NS + "findTodayLog", memberId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public int updateEndTime(int workoutLogId, LocalTime endTime) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int result = 0;
        try {
            Map<String, Object> param = new HashMap<>();
            param.put("workoutLogId", workoutLogId);
            param.put("endTime", endTime);
            result = session.update(NS + "updateEndTime", param);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
}
