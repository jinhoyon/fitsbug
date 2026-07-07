package service.member;

import dto.member.WorkoutLogDTO;
import java.util.List;

public interface WorkoutLogService {
    int save(WorkoutLogDTO dto);
    List<WorkoutLogDTO> getListByMemberId(int memberId);
    List<WorkoutLogDTO> getListByEmail(String email);
    List<WorkoutLogDTO> getTodayByMemberId(int memberId);
}
