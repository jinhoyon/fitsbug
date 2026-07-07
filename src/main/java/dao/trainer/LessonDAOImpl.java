
package dao.trainer;

import dto.common.LessonDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import util.MybatisSqlSessionFactory;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LessonDAOImpl implements LessonDAO {
    private final SqlSessionFactory sqlSessionFactory = MybatisSqlSessionFactory.getSqlSessionFactory();

    @Override
    public List<LessonDTO> selectLessonsByDate(SqlSession session, LocalDate date, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("date", date.toString());
        params.put("trainerId", trainerId);
        return session.selectList("lesson.findLessonsByDate", params);
    }

    @Override
    public List<LessonDTO> selectLessonsByDateRange(SqlSession session, LocalDate startDate, LocalDate endDate, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate.toString());
        params.put("endDate", endDate.toString());
        params.put("trainerId", trainerId);
        return session.selectList("lesson.findLessonsByDateRange", params);
    }

    @Override
    public List<Map<String, Object>> selectLessonCountsByMonth(SqlSession session, int year, int month, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("year", year);
        params.put("month", month);
        params.put("trainerId", trainerId);
        return session.selectList("lesson.findLessonCountsByMonth", params);
    }
}

//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)