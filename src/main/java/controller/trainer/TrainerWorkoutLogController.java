package controller.trainer;

import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import dto.common.TrainerDTO;
import org.json.JSONArray;
import org.json.JSONObject;
import service.trainer.WorkoutService;
import service.trainer.WorkoutServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer/workoutLog")
public class TrainerWorkoutLogController extends HttpServlet {

    private final WorkoutService workoutService = new WorkoutServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            if ("list".equals(action)) {
                int clientId = Integer.parseInt(request.getParameter("clientId"));
                List<Map<String, Object>> logs = workoutService.getLogsByClientId(clientId);

                JSONArray arr = new JSONArray();
                for (Map<String, Object> row : logs) {
                    JSONObject obj = new JSONObject();
                    obj.put("id",            row.get("id"));
                    obj.put("date",          row.getOrDefault("date", ""));
                    obj.put("startTime",     row.getOrDefault("startTime", ""));
                    obj.put("endTime",       row.getOrDefault("endTime", ""));
                    obj.put("exerciseCount", ((Number) row.get("exerciseCount")).intValue());
                    arr.put(obj);
                }
                out.print(new JSONObject().put("logs", arr));

            } else if ("detail".equals(action)) {
                int logId = Integer.parseInt(request.getParameter("logId"));
                WorkoutLogDTO log = workoutService.getLogById(logId);

                JSONObject obj = new JSONObject();
                if (log != null) {
                    obj.put("id",        log.getId());
                    obj.put("date",      log.getDate() != null ? log.getDate().toString() : "");
                    obj.put("startTime", formatTime(log.getStartTime()));
                    obj.put("endTime",   formatTime(log.getEndTime()));

                    JSONArray details = new JSONArray();
                    if (log.getDetails() != null) {
                        for (WorkoutDetailDTO d : log.getDetails()) {
                            JSONObject dObj = new JSONObject();
                            dObj.put("id",     d.getId());
                            dObj.put("title",  d.getTitle());
                            dObj.put("set",    d.getSet());
                            dObj.put("rep",    d.getRep());
                            dObj.put("weight", d.getWeight());
                            details.put(dObj);
                        }
                    }
                    obj.put("details", details);
                }
                out.print(obj);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print(new JSONObject().put("error", e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            out.print(new JSONObject().put("success", false).put("message", "인증 필요"));
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");

        try {
            String mode = request.getParameter("mode");
            List<WorkoutDetailDTO> details = buildDetails(
                    request.getParameterValues("exerciseName"),
                    request.getParameterValues("exerciseSet"),
                    request.getParameterValues("exerciseRep"),
                    request.getParameterValues("exerciseWeight")
            );

            int savedLogId;

            if ("append".equals(mode)) {
                String logIdStr = request.getParameter("logId");
                if (logIdStr == null || logIdStr.isEmpty()) {
                    out.print(new JSONObject().put("success", false).put("message", "logId 누락"));
                    return;
                }
                int logId = Integer.parseInt(logIdStr);
                savedLogId = workoutService.appendToLog(logId, details);
            } else {
                String clientIdStr = request.getParameter("clientId");
                String lessonIdStr = request.getParameter("lessonId");
                if (clientIdStr == null || clientIdStr.isEmpty()
                        || lessonIdStr == null || lessonIdStr.isEmpty()) {
                    out.print(new JSONObject().put("success", false).put("message", "필수 파라미터(clientId/lessonId) 누락"));
                    return;
                }
                int clientId = Integer.parseInt(clientIdStr);
                int lessonId = Integer.parseInt(lessonIdStr);

                Integer gymId = workoutService.getGymIdByClientAndTrainer(clientId, trainer.getTrainerId());

                WorkoutLogDTO log = new WorkoutLogDTO();
                log.setMemberId(clientId);
                log.setSessionId(lessonId);
                log.setDate(LocalDate.now());
                log.setStartTime(parseTime(request.getParameter("startTime")));
                log.setEndTime(parseTime(request.getParameter("endTime")));
                log.setGymId(gymId != null ? gymId : 0);

                savedLogId = workoutService.saveNewLog(log, details);
            }

            out.print(new JSONObject().put("success", true).put("logId", savedLogId));

        } catch (Exception e) {
            e.printStackTrace();
            out.print(new JSONObject().put("success", false).put("message", e.getMessage()));
        }
    }

    private List<WorkoutDetailDTO> buildDetails(String[] names, String[] sets, String[] reps, String[] weights) {
        List<WorkoutDetailDTO> list = new ArrayList<>();
        if (names == null) return list;
        for (int i = 0; i < names.length; i++) {
            if (names[i] == null || names[i].trim().isEmpty()) continue;
            WorkoutDetailDTO d = new WorkoutDetailDTO();
            d.setTitle(names[i].trim());
            d.setSet(parseIntSafe(sets, i));
            d.setRep(parseIntSafe(reps, i));
            d.setWeight(parseDoubleSafe(weights, i));
            list.add(d);
        }
        return list;
    }

    private String formatTime(LocalTime t) {
        if (t == null) return "";
        String s = t.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }

    private LocalTime parseTime(String s) {
        if (s == null || s.trim().isEmpty()) return null;
        try { return LocalTime.parse(s.trim()); } catch (Exception e) { return null; }
    }

    private int parseIntSafe(String[] arr, int i) {
        if (arr == null || i >= arr.length || arr[i] == null || arr[i].isEmpty()) return 0;
        try { return Integer.parseInt(arr[i]); } catch (Exception e) { return 0; }
    }

    private double parseDoubleSafe(String[] arr, int i) {
        if (arr == null || i >= arr.length || arr[i] == null || arr[i].isEmpty()) return 0.0;
        try { return Double.parseDouble(arr[i]); } catch (Exception e) { return 0.0; }
    }
}
