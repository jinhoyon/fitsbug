package dao.member;

import dto.member.WorkoutLogDTO;
import java.time.LocalTime;
import java.util.List;

public interface WorkoutLogDAO {

    int insert(WorkoutLogDTO dto);
    int insertWithDetails(WorkoutLogDTO dto);

    List<WorkoutLogDTO> findByMemberId(int memberId);


    List<WorkoutLogDTO> findByEmail(String email);


    List<WorkoutLogDTO> findTodayByMemberId(int memberId);

    // 오늘 workout_log 단건 조회 (start_time/end_time 관리용)
    WorkoutLogDTO findTodayLog(int memberId);

    // end_time 업데이트 (운동 추가할 때마다 마지막 시간 갱신)
    int updateEndTime(int workoutLogId, LocalTime endTime);
}
