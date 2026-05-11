package dao.trainer;

import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public interface WorkoutDAO {
    List<WorkoutLogDTO> findAllLogsByClientId(SqlSession session, int clientId);
    List<Map<String, Object>> findLogsByClientId(SqlSession session, int clientId);
    WorkoutLogDTO findLogById(SqlSession session, int logId);
    int insertLog(SqlSession session, WorkoutLogDTO dto);
    void insertDetail(SqlSession session, WorkoutDetailDTO dto);
    Integer findGymIdByClientAndTrainer(SqlSession session, int clientId, int trainerId);
}
