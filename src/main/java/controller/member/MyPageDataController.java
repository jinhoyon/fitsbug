package controller.member;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.common.UserDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

/**
 * 마이페이지 AJAX 데이터 컨트롤러
 *
 * GET  /member/mypageData?type=payment   → 결제 내역 JSON
 * GET  /member/mypageData?type=membership → 이용 중인 회원권 JSON
 * GET  /member/mypageData?type=feedback   → 최근 PT 피드백 JSON
 * GET  /member/mypageData?type=owun       → 오운완 날짜 목록 JSON
 * POST /member/mypageData?type=refund     → 환불 요청
 * POST /member/mypageData?type=cancel     → 회원권 취소
 */
@WebServlet("/member/mypageData")
public class MyPageDataController extends HttpServlet {

    private static final String NS = "mapper.MyPageMapper.";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.setStatus(401);
            resp.getWriter().write("[]");
            return;
        }

        UserDTO user   = (UserDTO) session.getAttribute("loginUser");
        int     userId = user.getId();

        // memberInfo에서 memberId 추출
        int memberId = getMemberIdFromSession(session, userId);

        String type = nvl(req.getParameter("type"));

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            switch (type) {

                // ── 결제 내역 ────────────────────────────────────────
                case "payment": {
                    List<Map<String, Object>> list =
                        sql.selectList(NS + "findPaymentsByUserId", userId);
                    resp.getWriter().write(listToJson(list));
                    break;
                }

                // ── 이용 중인 회원권 ─────────────────────────────────
                case "membership": {
                    Map<String, Object> mp =
                        sql.selectOne(NS + "findActiveMembership", memberId);
                    resp.getWriter().write(mp != null ? mapToJson(mp) : "null");
                    break;
                }

                // ── 최근 PT 피드백 ────────────────────────────────────
                case "feedback": {
                    List<Map<String, Object>> list =
                        sql.selectList(NS + "findFeedbackByMemberId", memberId);
                    resp.getWriter().write(listToJson(list));
                    break;
                }

                // ── 오운완 출석 날짜 ──────────────────────────────────
                case "owun": {
                    List<String> dates =
                        sql.selectList(NS + "findOwunDates", userId);
                    // streak 계산
                    int streak = calcStreak(dates);
                    StringBuilder json = new StringBuilder();
                    json.append("{\"streak\":").append(streak).append(",\"dates\":[");
                    for (int i = 0; i < dates.size(); i++) {
                        if (i > 0) json.append(",");
                        json.append("\"").append(dates.get(i)).append("\"");
                    }
                    json.append("]}");
                    resp.getWriter().write(json.toString());
                    break;
                }

                default:
                    resp.getWriter().write("[]");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("[]");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.getWriter().write("{\"result\":\"notLogin\"}");
            return;
        }

        UserDTO user   = (UserDTO) session.getAttribute("loginUser");
        int     userId = user.getId();
        int     memberId = getMemberIdFromSession(session, userId);

        String type  = nvl(req.getParameter("type"));
        int    mpId  = parseIntOrZero(req.getParameter("mpId"));

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            switch (type) {

                // ── 환불 요청 ─────────────────────────────────────────
                case "refund": {
                    String reason = nvl(req.getParameter("reason"));
                    java.util.Map<String, Object> param = new java.util.HashMap<>();
                    param.put("mpId",   mpId);
                    param.put("userId", userId);
                    param.put("reason", reason.isEmpty() ? "환불 요청" : reason);
                    sql.update(NS + "requestRefund", param);
                    // membership_pt 상태 expired로
                    java.util.Map<String, Object> p2 = new java.util.HashMap<>();
                    p2.put("mpId",     mpId);
                    p2.put("memberId", memberId);
                    sql.update(NS + "cancelMembership", p2);
                    sql.commit();
                    resp.getWriter().write("{\"result\":\"ok\"}");
                    break;
                }

                // ── 취소 ─────────────────────────────────────────────
                case "cancel": {
                    java.util.Map<String, Object> param = new java.util.HashMap<>();
                    param.put("mpId",     mpId);
                    param.put("memberId", memberId);
                    sql.update(NS + "cancelMembership", param);
                    sql.commit();
                    resp.getWriter().write("{\"result\":\"ok\"}");
                    break;
                }

                default:
                    resp.getWriter().write("{\"result\":\"error\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"result\":\"error\",\"msg\":\"" + esc(e.getMessage()) + "\"}");
        }
    }

    // ── 연속 스트릭 계산 ─────────────────────────────────────────────
    private int calcStreak(List<String> dates) {
        if (dates == null || dates.isEmpty()) return 0;
        LocalDate today = LocalDate.now();
        int streak = 0;
        for (String dateStr : dates) {
            try {
                LocalDate d = LocalDate.parse(dateStr.substring(0, 10));
                long diff = ChronoUnit.DAYS.between(d, today);
                if (diff == streak) streak++;
                else if (diff > streak) break;
            } catch (Exception ignored) {}
        }
        return streak;
    }

    // ── session에서 memberId 추출 ────────────────────────────────────
    @SuppressWarnings("unchecked")
    private int getMemberIdFromSession(HttpSession session, int userId) {
        Object cached = session.getAttribute("memberInfo");
        if (cached instanceof Map) {
            Object id = ((Map<String, Object>) cached).get("id");
            if (id != null) {
                try { return Integer.parseInt(String.valueOf(id)); } catch (Exception ignored) {}
            }
        }
        // fallback: UserDTO.getOtherId()
        UserDTO u = (UserDTO) session.getAttribute("loginUser");
        if (u != null && u.getOtherId() != null) return u.getOtherId();
        return 0;
    }

    // ── Map/List → JSON (간이 직렬화) ────────────────────────────────
    private String listToJson(List<Map<String, Object>> list) {
        if (list == null) return "[]";
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(mapToJson(list.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }

    private String mapToJson(Map<String, Object> map) {
        if (map == null) return "null";
        StringBuilder sb = new StringBuilder("{");
        boolean first = true;
        for (Map.Entry<String, Object> e : map.entrySet()) {
            if (!first) sb.append(",");
            first = false;
            sb.append("\"").append(e.getKey()).append("\":");
            Object v = e.getValue();
            if (v == null)              sb.append("null");
            else if (v instanceof Number) sb.append(v);
            else if (v instanceof Boolean) sb.append(v);
            else                        sb.append("\"").append(esc(String.valueOf(v))).append("\"");
        }
        sb.append("}");
        return sb.toString();
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r");
    }
    private String nvl(String s) { return s == null ? "" : s; }
    private int parseIntOrZero(String s) {
        try { return s != null ? Integer.parseInt(s.trim()) : 0; } catch (Exception e) { return 0; }
    }
}
