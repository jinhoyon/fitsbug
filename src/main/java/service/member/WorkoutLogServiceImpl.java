package service.member;

import dao.member.WorkoutLogDAO;
import dao.member.WorkoutLogDAOImpl;
import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.time.LocalTime;
import java.util.List;

public class WorkoutLogServiceImpl implements WorkoutLogService {

    private WorkoutLogDAO dao = new WorkoutLogDAOImpl();

    @Override
    public int save(WorkoutLogDTO dto) {
        LocalTime now = LocalTime.now().withNano(0); // 초 단위까지만

        WorkoutLogDTO todayLog = dao.findTodayLog(dto.getMemberId());

        if (todayLog == null) {
            // ── 첫 번째 운동: start_time = now, end_time = now ──
            dto.setStartTime(now);
            dto.setEndTime(now);
            return dao.insertWithDetails(dto); // log INSERT + detail INSERT

        } else {
            // ── 추가 운동: 기존 log 재사용, end_time만 갱신 ──
            int logId = todayLog.getId();
            dao.updateEndTime(logId, now);     // end_time UPDATE

            // workout_detail만 INSERT (기존 log id 사용)
            if (dto.getDetails() != null && !dto.getDetails().isEmpty()) {
                SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
                try {
                    for (WorkoutDetailDTO detail : dto.getDetails()) {
                        detail.setWorkoutId(logId);
                        session.insert("mapper.member.workout_log.insertDetail", detail);
                    }
                    session.commit();
                } catch (Exception e) {
                    session.rollback();
                    e.printStackTrace();
                    return 0;
                } finally {
                    session.close();
                }
            }
            // 컨트롤러에서 dto.getId()로 workoutId를 참조하므로 세팅
            dto.setId(logId);
            return 1;
        }
    }

    @Override
    public List<WorkoutLogDTO> getListByMemberId(int memberId) {
        return dao.findByMemberId(memberId);
    }

    @Override
    public List<WorkoutLogDTO> getListByEmail(String email) {
        return dao.findByEmail(email);
    }

    @Override
    public List<WorkoutLogDTO> getTodayByMemberId(int memberId) {
        List<WorkoutLogDTO> list = dao.findTodayByMemberId(memberId);
        return list != null ? list : java.util.Collections.emptyList();
    }
}
