package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.UserDTO;
import dto.member.PtFeedbackDTO;
import service.member.PtFeedbackService;
import service.member.PtFeedbackServiceImpl;

@WebServlet("/member/ptFeedback")
public class PtFeedbackController extends HttpServlet {

    private PtFeedbackService service = new PtFeedbackServiceImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        UserDTO user = (UserDTO) req.getSession().getAttribute("loginUser");

        String mode = req.getParameter("mode");

        // 🔥 상세 조회
        if ("detail".equals(mode)) {

            int id = Integer.parseInt(req.getParameter("id"));
            PtFeedbackDTO dto = service.getDetail(id);

            StringBuilder json = new StringBuilder();
            json.append("{");

            json.append("\"id\":").append(dto.getId()).append(",");
            json.append("\"sessionDate\":\"").append(dto.getSessionDate()).append("\",");

            json.append("\"exercise\":\"").append(nullSafe(dto.getExercise())).append("\",");
            json.append("\"food\":\"").append(nullSafe(dto.getFood())).append("\",");
            json.append("\"inbody\":\"").append(nullSafe(dto.getInbody())).append("\",");

            json.append("\"growth\":\"").append(nullSafe(dto.getGrowth())).append("\",");
            json.append("\"nextPlan\":\"").append(nullSafe(dto.getNextPlan())).append("\"");

            json.append("}");

            resp.getWriter().write(json.toString());
            return;
        }

        // 🔥 리스트 조회
        List<PtFeedbackDTO> list = service.getList(user.getEmail());

        StringBuilder json = new StringBuilder();
        json.append("[");

        for (PtFeedbackDTO dto : list) {

            json.append("{");

            json.append("\"id\":").append(dto.getId()).append(",");
            json.append("\"sessionDate\":\"").append(dto.getSessionDate()).append("\"");

            json.append("},");
        }

        // 마지막 콤마 제거
        if (list.size() > 0) {
            json.deleteCharAt(json.length() - 1);
        }

        json.append("]");

        resp.getWriter().write(json.toString());
    }

    // 🔥 null 방지 + JSON 깨짐 방지
    private String nullSafe(String str) {
        if (str == null) return "";

        // 따옴표 escape 처리
        return str.replace("\"", "\\\"");
    }
}