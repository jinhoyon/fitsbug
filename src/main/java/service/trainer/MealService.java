package service.trainer;

import dao.trainer.MealDAO;
import dao.trainer.MealDAOImpl;
import dto.trainer.MealDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MealService {

    private final MealDAO mealDAO = new MealDAOImpl();

    public static class WeekResult {
        public final List<MealDTO> weekMeals;
        public final List<MealDTO> dayMeals;
        public final boolean isDailyView;
        public final String selectedDate;
        public final int avgCal, avgProt, avgCarbs, avgFat;
        public final int dayCal, dayProt, dayCarbs, dayFat;
        public final Map<String, Integer> chartData;

        public WeekResult(List<MealDTO> weekMeals, List<MealDTO> dayMeals,
                          boolean isDailyView, String selectedDate,
                          int avgCal, int avgProt, int avgCarbs, int avgFat,
                          int dayCal, int dayProt, int dayCarbs, int dayFat,
                          Map<String, Integer> chartData) {
            this.weekMeals    = weekMeals;
            this.dayMeals     = dayMeals;
            this.isDailyView  = isDailyView;
            this.selectedDate = selectedDate;
            this.avgCal       = avgCal;
            this.avgProt      = avgProt;
            this.avgCarbs     = avgCarbs;
            this.avgFat       = avgFat;
            this.dayCal       = dayCal;
            this.dayProt      = dayProt;
            this.dayCarbs     = dayCarbs;
            this.dayFat       = dayFat;
            this.chartData    = chartData;
        }
    }

    public WeekResult getMealData(int memberId, int weekOffset, String selectedDate) {
        boolean isDailyView = (selectedDate != null && !selectedDate.isEmpty());
        if (!isDailyView) {
            selectedDate = "";
        }

        LocalDate targetDate = LocalDate.now().plusWeeks(weekOffset);
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            List<MealDTO> weekMeals = mealDAO.selectMealsByWeek(session, memberId, targetDate);
            List<MealDTO> dayMeals = isDailyView
                    ? mealDAO.selectMealsByDay(session, memberId, selectedDate)
                    : new ArrayList<>();

            int totalCal = 0, totalProt = 0, totalCarbs = 0, totalFat = 0;
            for (MealDTO meal : weekMeals) {
                totalCal   += meal.getCalories();
                totalProt  += meal.getProtein();
                totalCarbs += meal.getCarbs();
                totalFat   += meal.getFat();
            }
            long days = weekMeals.stream().map(MealDTO::getMealDate).distinct().count();
            int divisor = (days > 0) ? (int) days : 1;

            int dayCal = 0, dayProt = 0, dayCarbs = 0, dayFat = 0;
            for (MealDTO meal : dayMeals) {
                dayCal   += meal.getCalories();
                dayProt  += meal.getProtein();
                dayCarbs += meal.getCarbs();
                dayFat   += meal.getFat();
            }

            Map<String, Integer> chartData = new LinkedHashMap<>();
            for (MealDTO meal : weekMeals) {
                chartData.merge(meal.getMealDate(), meal.getCalories(), Integer::sum);
            }

            return new WeekResult(
                    weekMeals, dayMeals, isDailyView, selectedDate,
                    totalCal / divisor, totalProt / divisor,
                    totalCarbs / divisor, totalFat / divisor,
                    dayCal, dayProt, dayCarbs, dayFat,
                    chartData
            );
        } finally {
            session.close();
        }
    }
}
