package dao.trainer;

import dto.trainer.MealDTO;
import org.apache.ibatis.session.SqlSession;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MealDAOImpl implements MealDAO {

    @Override
    public List<MealDTO> selectMealsByDay(SqlSession session, int clientId, String day) {
        Map<String, Object> param = new HashMap<>();
        param.put("userId", clientId);
        param.put("date", day);
        return session.selectList("mapper.trainer.meal.selectMealsByDay", param);
    }

    @Override
    public List<MealDTO> selectMealsByWeek(SqlSession session, int clientId, LocalDate anyDateInWeek) {
        LocalDate monday = anyDateInWeek;
        while (monday.getDayOfWeek() != DayOfWeek.MONDAY) {
            monday = monday.minusDays(1);
        }
        LocalDate sunday = monday.plusDays(6);

        Map<String, Object> param = new HashMap<>();
        param.put("userId", clientId);
        param.put("monday", monday.toString());
        param.put("sunday", sunday.toString());

        return session.selectList("mapper.trainer.meal.selectMealsByWeek", param);
    }
}
