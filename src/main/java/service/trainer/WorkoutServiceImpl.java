package service.trainer;

import dao.trainer.WorkoutDAO;
import dao.trainer.WorkoutDAOImpl;
import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.List;
import java.util.Map;

public class WorkoutServiceImpl implements WorkoutService {

    private final WorkoutDAO workoutDAO = new WorkoutDAOImpl();

    @Override
    public List<WorkoutLogDTO> getAllLogsByClientId(int clientId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return workoutDAO.findAllLogsByClientId(session, clientId);
        } finally {
            session.close();
        }
    }

    @Override
    public List<Map<String, Object>> getLogsByClientId(int clientId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return workoutDAO.findLogsByClientId(session, clientId);
        } finally {
            session.close();
        }
    }

    @Override
    public WorkoutLogDTO getLogById(int logId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return workoutDAO.findLogById(session, logId);
        } finally {
            session.close();
        }
    }

    @Override
    public int saveNewLog(WorkoutLogDTO log, List<WorkoutDetailDTO> details) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            workoutDAO.insertLog(session, log);
            if (details != null) {
                for (WorkoutDetailDTO d : details) {
                    d.setWorkoutId(log.getId());
                    workoutDAO.insertDetail(session, d);
                }
            }
            session.commit();
            return log.getId();
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Failed to save workout log", e);
        } finally {
            session.close();
        }
    }

    @Override
    public int appendToLog(int logId, List<WorkoutDetailDTO> details) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            if (details != null) {
                for (WorkoutDetailDTO d : details) {
                    d.setWorkoutId(logId);
                    workoutDAO.insertDetail(session, d);
                }
            }
            session.commit();
            return logId;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Failed to append to workout log", e);
        } finally {
            session.close();
        }
    }

    @Override
    public Integer getGymIdByClientAndTrainer(int clientId, int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return workoutDAO.findGymIdByClientAndTrainer(session, clientId, trainerId);
        } finally {
            session.close();
        }
    }
}
