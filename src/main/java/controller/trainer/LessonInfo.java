package controller.trainer;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.trainer.ClientDAOImpl;
import dao.trainer.LessonDAO;
import dao.trainer.LessonDAOImpl;
import dto.trainer.ClientDTO;
import dto.trainer.LessonDTO;
import dto.trainer.LessonInfoResponse;
import dto.trainer.TrainerDTO;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;
import service.trainer.LessonService;
import service.trainer.LessonServiceImpl;

public class LessonInfo extends HttpServlet {
    private final LessonService lessonService = new LessonServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // 2. Get trainerId
        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        int trainerId = trainer.getTrainerId();

        // 3. Parse lessonId
        Integer lessonId = parseLessonId(request.getParameter("lessonId"));
        if (lessonId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "lessonId is required");
            return;
        }

        try {
            // ✅ 4. CALL SERVICE (this replaces everything you had before)
            LessonInfoResponse result =
                    lessonService.getLessonInfo(trainerId, lessonId);

            if (result == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Lesson not found");
                return;
            }

            // ✅ 5. Return JSON (temporary manual version)
            response.setContentType("application/json;charset=UTF-8");

            String json = "{" +
                    "\"lessonId\":" + result.getLessonId() + "," +
                    "\"goal\":\"" + escapeJson(result.getGoal()) + "\"," +
                    "\"memberName\":\"" + escapeJson(result.getMemberName()) + "\"," +
                    "\"startTime\":\"" + escapeJson(result.getStartTime()) + "\"," +
                    "\"endTime\":\"" + escapeJson(result.getEndTime()) + "\"," +
                    "\"durationMinutes\":" + result.getDurationMinutes() + "," +
                    "\"status\":\"" + escapeJson(result.getStatus()) + "\"," +
                    "\"lessonCount\":" + result.getLessonCount() +
                    "}";

            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private Integer parseLessonId(String raw) {
        try {
            return raw == null ? null : Integer.parseInt(raw);
        } catch (Exception e) {
            return null;
        }
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}