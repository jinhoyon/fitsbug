package controller.trainer;

import dto.trainer.LessonDTO;
import dto.common.TrainerDTO;
import service.trainer.LessonService;
import service.trainer.LessonServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/trainer/calendar")
public class CalendarController extends HttpServlet {

    private static final String[] KOR_DOW = {"월", "화", "수", "목", "금", "토", "일"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        int trainerId = trainer.getTrainerId();

        LessonService lessonService = new LessonServiceImpl();

        // -- Parse view param --
        String view = request.getParameter("view");
        if (view == null || (!view.equals("day") && !view.equals("week") && !view.equals("month"))) {
            view = "week";
        }

        // -- Parse date param --
        LocalDate selectedDate;
        try {
            String dp = request.getParameter("date");
            selectedDate = (dp != null && !dp.isEmpty()) ? LocalDate.parse(dp) : LocalDate.now();
        } catch (Exception e) {
            selectedDate = LocalDate.now();
        }

        LocalDate today = LocalDate.now();
        LocalDate prevDate, nextDate;

        // ── DAY VIEW ──────────────────────────────────────────────────────────
        if ("day".equals(view)) {
            prevDate = selectedDate.minusDays(1);
            nextDate = selectedDate.plusDays(1);

            List<LessonDTO> dayLessons = lessonService.getLessonsByDate(selectedDate, trainerId);
            request.setAttribute("dayLessons", dayLessons);
            request.setAttribute("isToday", selectedDate.equals(today));

            request.setAttribute("dateLabel",
                    selectedDate.getYear() + "년 " + selectedDate.getMonthValue() + "월 " +
                    selectedDate.getDayOfMonth() + "일 (" + KOR_DOW[selectedDate.getDayOfWeek().getValue() - 1] + ")");

        // ── WEEK VIEW ─────────────────────────────────────────────────────────
        } else if ("week".equals(view)) {
            LocalDate monday = selectedDate.with(DayOfWeek.MONDAY);
            LocalDate sunday  = monday.plusDays(6);
            prevDate = monday.minusWeeks(1);
            nextDate = monday.plusWeeks(1);

            List<LessonDTO> lessons = lessonService.getLessonsByDateRange(monday, sunday, trainerId);

            // Group lessons by date string
            Map<String, List<LessonDTO>> byDate = new LinkedHashMap<>();
            for (int i = 0; i < 7; i++) byDate.put(monday.plusDays(i).toString(), new ArrayList<>());
            for (LessonDTO l : lessons) {
                List<LessonDTO> list = byDate.get(l.getLessonDate());
                if (list != null) list.add(l);
            }

            // Build structured weekColumns for JSP
            List<Map<String, Object>> weekColumns = new ArrayList<>();
            for (int i = 0; i < 7; i++) {
                LocalDate day = monday.plusDays(i);
                Map<String, Object> col = new HashMap<>();
                col.put("dayName",  KOR_DOW[i]);
                col.put("dayNum",   day.getDayOfMonth());
                col.put("dateStr",  day.toString());
                col.put("isToday",  day.equals(today));
                col.put("lessons",  byDate.getOrDefault(day.toString(), new ArrayList<>()));
                weekColumns.add(col);
            }
            request.setAttribute("weekColumns", weekColumns);

            // Date label
            String label;
            if (monday.getMonth() == sunday.getMonth()) {
                label = monday.getYear() + "년 " + monday.getMonthValue() + "월 " +
                        monday.getDayOfMonth() + "일 – " + sunday.getDayOfMonth() + "일";
            } else {
                label = monday.getMonthValue() + "월 " + monday.getDayOfMonth() + "일 – " +
                        sunday.getMonthValue() + "월 " + sunday.getDayOfMonth() + "일";
            }
            request.setAttribute("dateLabel", label);

        // ── MONTH VIEW ────────────────────────────────────────────────────────
        } else {
            LocalDate firstOfMonth = selectedDate.withDayOfMonth(1);
            prevDate = firstOfMonth.minusMonths(1);
            nextDate = firstOfMonth.plusMonths(1);

            Map<String, Integer> counts = lessonService.getLessonCountsByMonth(
                    selectedDate.getYear(), selectedDate.getMonthValue(), trainerId);

            int firstDow     = firstOfMonth.getDayOfWeek().getValue(); // 1=Mon, 7=Sun
            int daysInMonth  = selectedDate.lengthOfMonth();

            List<Map<String, Object>> monthGrid = new ArrayList<>();

            // Leading blanks
            for (int i = 1; i < firstDow; i++) {
                Map<String, Object> blank = new HashMap<>();
                blank.put("blank", true);
                monthGrid.add(blank);
            }
            // Day cells
            for (int d = 1; d <= daysInMonth; d++) {
                LocalDate day = firstOfMonth.withDayOfMonth(d);
                Map<String, Object> cell = new HashMap<>();
                cell.put("blank",   false);
                cell.put("day",     d);
                cell.put("dateStr", day.toString());
                cell.put("count",   counts.getOrDefault(day.toString(), 0));
                cell.put("isToday", day.equals(today));
                monthGrid.add(cell);
            }

            request.setAttribute("monthGrid", monthGrid);
            request.setAttribute("monthYear", selectedDate.getYear());
            request.setAttribute("monthNum",  selectedDate.getMonthValue());
            request.setAttribute("dateLabel", selectedDate.getYear() + "년 " + selectedDate.getMonthValue() + "월");
        }

        request.setAttribute("view",         view);
        request.setAttribute("selectedDate", selectedDate.toString());
        request.setAttribute("prevDate",     prevDate.toString());
        request.setAttribute("nextDate",     nextDate.toString());
        request.setAttribute("todayDate",    today.toString());

        request.getRequestDispatcher("/trainer/calendar.jsp").forward(request, response);
    }
}
