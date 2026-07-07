package dao.trainer;

import dto.trainer.MealDTO;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDate;
import java.util.List;

public interface MealDAO {
    List<MealDTO> selectMealsByDay(SqlSession session, int clientId, String day);

    List<MealDTO> selectMealsByWeek(SqlSession session, int clientId, LocalDate anyDateInWeek);
}
