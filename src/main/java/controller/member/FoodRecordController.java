package controller.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.member.MealLogDTO;
import dto.member.UserDTO;
import service.member.MealLogService;
import service.member.MealLogServiceImpl;

@WebServlet("/member/food")
public class FoodRecordController extends HttpServlet {

    private MealLogService service = new MealLogServiceImpl();

    // ── GET: 식단 목록 조회 (차트용 AJAX) ─────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");

        UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");
        if (user == null) { response.setStatus(401); return; }

        List<MealLogDTO> list = service.getListByEmail(user.getEmail());
        if (list == null) list = new ArrayList<>();

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            MealLogDTO f = list.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"id\":").append(f.getId()).append(",")
                .append("\"date\":\"").append(nvl(f.getMealDate())).append("\",")
                .append("\"food\":\"").append(esc(f.getMeal())).append("\",")
                .append("\"calorie\":").append(f.getTotCalorie()).append(",")
                .append("\"calories\":").append(f.getCalories()).append(",")
                .append("\"protein\":").append(f.getProtein()).append(",")
                .append("\"carbs\":").append(f.getCarbs()).append(",")
                .append("\"fat\":").append(f.getFat()).append(",")
                .append("\"mealTime\":\"").append(nvl(f.getMealTime())).append("\"")
                .append("}");
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");
        if (user == null) {
            response.getWriter().write("{\"success\":false,\"msg\":\"notLogin\"}");
            return;
        }

        int memberId = user.getOtherId();

        // 모달 파라미터 — DB 컬럼이 아닌 필드는 로컬 변수로만 처리
        String foodName = nvl(request.getParameter("foodName")).trim();
        double gram     = parseDoubleOrZero(request.getParameter("gram"));
        double calorie  = parseDoubleOrZero(request.getParameter("calorie"));

        String mealParam = request.getParameter("meal");
        String mealText;
        if (mealParam != null && !mealParam.trim().isEmpty()) {
            mealText = mealParam.trim();
        } else if (!foodName.isEmpty()) {
            mealText = foodName + (gram > 0 ? " " + (int) gram + "g" : "");
        } else {
            response.getWriter().write("{\"success\":false,\"msg\":\"음식명을 입력해주세요\"}");
            return;
        }

        String totCalStr = request.getParameter("totCalorie");
        int totCalorie = (totCalStr != null && !totCalStr.trim().isEmpty())
                ? parseIntOrZero(totCalStr)
                : (int) calorie;

        String today         = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String nowTime       = new SimpleDateFormat("HH:mm:ss").format(new Date());
        String mealTimeParam = request.getParameter("mealTime");

        MealLogDTO dto = new MealLogDTO();
        dto.setMemberId(memberId);
        dto.setMealDate(today);
        dto.setMeal(mealText);
        dto.setDescription(request.getParameter("description"));
        dto.setTotCalorie(totCalorie);
        dto.setMealTime(mealTimeParam != null && !mealTimeParam.isEmpty() ? mealTimeParam : nowTime);
        dto.setCalories(totCalorie);  
        dto.setProtein(parseIntOrZero(request.getParameter("protein")));
        dto.setCarbs(parseIntOrZero(request.getParameter("carbs")));
        dto.setFat(parseIntOrZero(request.getParameter("fat")));
        dto.setImageUrl(request.getParameter("imageUrl"));

        int result = service.save(dto);

        if (result > 0) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.getWriter().write("{\"success\":false}");
        }
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r");
    }
    private String nvl(String s) { return s == null ? "" : s; }
    private int parseIntOrZero(String s) {
        try { return s != null && !s.trim().isEmpty() ? Integer.parseInt(s.trim()) : 0; }
        catch (Exception e) { return 0; }
    }
    private double parseDoubleOrZero(String s) {
        try { return s != null && !s.trim().isEmpty() ? Double.parseDouble(s.trim()) : 0; }
        catch (Exception e) { return 0; }
    }
}
