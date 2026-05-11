package dao.trainer;

import dao.trainer.MealDAO;
import dto.trainer.MealDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MealDAOImpl implements MealDAO {

    @Override
    public List<MealDTO> selectMealsByDay(int clientId, String day) {
        try (SqlSession session =
                     MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            Map<String, Object> param = new HashMap<>();
            param.put("userId", clientId);   // must match XML
            param.put("date", day);          // must match XML

            return session.selectList(
                    "mapper.trainer.meal.selectMealsByDay",
                    param
            );
        }
    }

    public List<MealDTO> selectMealsByWeek(int clientId, LocalDate anyDateInWeek) {

        // getMondayOfWeek logic
        LocalDate monday = anyDateInWeek;
        while (monday.getDayOfWeek() != DayOfWeek.MONDAY) {
            monday = monday.minusDays(1);
        }
        LocalDate sunday = monday.plusDays(6);

        try (SqlSession session =
                     MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            Map<String, Object> param = new HashMap<>();
            param.put("userId", clientId);
            param.put("monday", monday.toString());   // "2026-04-27"
            param.put("sunday", sunday.toString());   // "2026-05-03"

            return session.selectList(
                    "mapper.trainer.meal.selectMealsByWeek",
                    param
            );
        }
    }
}