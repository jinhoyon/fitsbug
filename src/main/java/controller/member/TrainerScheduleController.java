package controller.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.LessonDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

@WebServlet("/member/trainerSchedule")
public class TrainerScheduleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.getWriter().write("[]");
            return;
        }

        String trainerIdStr = req.getParameter("trainerId");
        String startDate    = req.getParameter("startDate");
        String endDate      = req.getParameter("endDate");

        if (trainerIdStr == null || startDate == null || endDate == null) {
            resp.getWriter().write("[]");
            return;
        }

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("trainerId", Integer.parseInt(trainerIdStr));
            params.put("startDate", startDate);
            params.put("endDate",   endDate);

            // LESSON 테이블에서 해당 트레이너의 전체 예약 조회 (취소 제외)
            List<LessonDTO> lessons = sql.selectList("mapper.LessonMapper.findMyLessonsByDateRange", params);

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < lessons.size(); i++) {
                LessonDTO l = lessons.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                    .append("\"lessonDate\":\"").append(nvl(l.getLessonDate())).append("\",")
                    .append("\"startTime\":\"").append(nvl(l.getStartTime())).append("\",")
                    .append("\"endTime\":\"").append(nvl(l.getEndTime())).append("\",")
                    .append("\"status\":\"").append(nvl(l.getStatus())).append("\"")
                    .append("}");
            }
            json.append("]");
            resp.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("[]");
        }
    }

    private String nvl(String s) { return s == null ? "" : s; }
}
