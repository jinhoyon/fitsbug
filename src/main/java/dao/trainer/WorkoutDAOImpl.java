package dao.trainer;

import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkoutDAOImpl implements WorkoutDAO {

    private static final String NS = "mapper.trainer.workout.";

    @Override
    public List<WorkoutLogDTO> findAllLogsByClientId(SqlSession session, int clientId) {
        return session.selectList(NS + "findAllLogsByClientId", clientId);
    }

    @Override
    public List<Map<String, Object>> findLogsByClientId(SqlSession session, int clientId) {
        return session.selectList(NS + "findLogsByClientId", clientId);
    }

    @Override
    public WorkoutLogDTO findLogById(SqlSession session, int logId) {
        return session.selectOne(NS + "findLogById", logId);
    }

    @Override
    public int insertLog(SqlSession session, WorkoutLogDTO dto) {
        return session.insert(NS + "insertLog", dto);
    }

    @Override
    public void insertDetail(SqlSession session, WorkoutDetailDTO dto) {
        session.insert(NS + "insertDetail", dto);
    }

    @Override
    public Integer findGymIdByClientAndTrainer(SqlSession session, int clientId, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("clientId", clientId);
        params.put("trainerId", trainerId);
        return session.selectOne(NS + "findGymIdByClientAndTrainer", params);
    }
}
