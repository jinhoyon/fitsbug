package service.trainer;

import dao.trainer.MealDAO;
import dao.trainer.MealDAOImpl;
import dto.trainer.MealDTO;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MealService {

    private MealDAO mealDAO = new MealDAOImpl();

    // ── Result container ──────────────────────────────────────────────────
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

    // ── Main method the servlet calls ─────────────────────────────────────
    public WeekResult getMealData(int memberId, int weekOffset, String selectedDate) {

        boolean isDailyView = (selectedDate != null && !selectedDate.isEmpty());
        if (!isDailyView) selectedDate = "";

        // Fetch data
        LocalDate targetDate = LocalDate.now().plusWeeks(weekOffset);
        List<MealDTO> weekMeals = mealDAO.selectMealsByWeek(memberId, targetDate);
        List<MealDTO> dayMeals  = isDailyView
                ? mealDAO.selectMealsByDay(memberId, selectedDate)
                : new ArrayList<>();

        // Week averages
        int totalCal = 0, totalProt = 0, totalCarbs = 0, totalFat = 0;
        for (MealDTO m : weekMeals) {
            totalCal   += m.getCalories();
            totalProt  += m.getProtein();
            totalCarbs += m.getCarbs();
            totalFat   += m.getFat();
        }
        long days = weekMeals.stream().map(MealDTO::getMealDate).distinct().count();
        int divisor = (days > 0) ? (int) days : 1;

        // Daily totals
        int dayCal = 0, dayProt = 0, dayCarbs = 0, dayFat = 0;
        for (MealDTO m : dayMeals) {
            dayCal   += m.getCalories();
            dayProt  += m.getProtein();
            dayCarbs += m.getCarbs();
            dayFat   += m.getFat();
        }

        // Chart data: date → total calories
        Map<String, Integer> chartData = new LinkedHashMap<>();
        for (MealDTO m : weekMeals) {
            chartData.merge(m.getMealDate(), m.getCalories(), Integer::sum);
        }

        return new WeekResult(
                weekMeals, dayMeals, isDailyView, selectedDate,
                totalCal / divisor, totalProt / divisor,
                totalCarbs / divisor, totalFat / divisor,
                dayCal, dayProt, dayCarbs, dayFat,
                chartData
        );
    }
}