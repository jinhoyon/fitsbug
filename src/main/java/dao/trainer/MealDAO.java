package dao.trainer;

import dto.trainer.MealDTO;

import java.time.LocalDate;
import java.util.List;

public interface MealDAO {
    public List<MealDTO> selectMealsByDay(int clientId, String day);
    public List<MealDTO> selectMealsByWeek(int clientId, LocalDate anyDateInWeek);
}