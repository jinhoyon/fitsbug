package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.ChartDTO;
import dto.common.UserDTO;
import service.member.ChartService;
import service.member.ChartServiceImpl;

@WebServlet("/member/chart")
public class ChartController extends HttpServlet {

    private ChartService service = new ChartServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        String type = req.getParameter("type");
        UserDTO user = (UserDTO) req.getSession().getAttribute("loginUser");

        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("[]");
            return;
        }

        List<ChartDTO> list = null;

        // ── DB 연동 (workout_log / meal_log / inbody_log) ──
        if ("workout".equals(type)) {
            list = service.getWorkoutChart(user.getEmail());
        } else if ("food".equals(type)) {
            list = service.getFoodChart(user.getEmail());
        } else if ("inbody".equals(type)) {
            list = service.getInbodyChart(user.getEmail());
        }

        if (list == null) list = new ArrayList<>();

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            ChartDTO c = list.get(i);
            json.append("{");
            json.append("\"date\":\"").append(nvl(c.getDate())).append("\",");

            if ("food".equals(type)) {
                json.append("\"food\":\"").append(nvl(c.getFood())).append("\",");
                json.append("\"calorie\":").append(c.getCalorie());
            } else if ("inbody".equals(type)) {
                json.append("\"weight\":").append(c.getWeight()).append(",");
                json.append("\"muscle\":").append(c.getMuscle()).append(",");
                json.append("\"fat\":").append(c.getFat());
            } else { // workout
                json.append("\"value\":").append(c.getValue());
            }

            json.append("}");
            if (i < list.size() - 1) json.append(",");
        }
        json.append("]");

        resp.getWriter().write(json.toString());
    }

    private String nvl(String s) { return s == null ? "" : s; }
}
