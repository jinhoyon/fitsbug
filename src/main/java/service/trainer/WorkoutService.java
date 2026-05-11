package service.trainer;

import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;

import java.util.List;
import java.util.Map;

public interface WorkoutService {
    List<WorkoutLogDTO> getAllLogsByClientId(int clientId);
    List<Map<String, Object>> getLogsByClientId(int clientId);
    WorkoutLogDTO getLogById(int logId);
    int saveNewLog(WorkoutLogDTO log, List<WorkoutDetailDTO> details);
    int appendToLog(int logId, List<WorkoutDetailDTO> details);
    Integer getGymIdByClientAndTrainer(int clientId, int trainerId);
}
