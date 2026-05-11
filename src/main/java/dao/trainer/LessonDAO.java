package dao.trainer;

import dto.trainer.LessonDTO;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface LessonDAO {
    List<LessonDTO> selectLessonsByDate(SqlSession session, LocalDate date, int trainerId);
    List<LessonDTO> selectLessonsByDateRange(SqlSession session, LocalDate startDate, LocalDate endDate, int trainerId);
    List<Map<String, Object>> selectLessonCountsByMonth(SqlSession session, int year, int month, int trainerId);
}

//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)