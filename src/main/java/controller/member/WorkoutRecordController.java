package controller.member;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dao.member.WorkoutLogDAO;
import dao.member.WorkoutLogDAOImpl;
import dto.common.UserDTO;
import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import service.member.WorkoutLogService;
import service.member.WorkoutLogServiceImpl;

@WebServlet("/member/workout")
public class WorkoutRecordController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WorkoutLogService service = new WorkoutLogServiceImpl();

    private WorkoutLogDAO logDao = new WorkoutLogDAOImpl();

    private MemberDAO memberDao = new MemberDAOImpl();

    /**
     * 오늘 운동 기록 조회
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        UserDTO user =
                (UserDTO) session.getAttribute("loginUser");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // ─────────────────────────────────────────────
        // MEMBER.id 조회
        // ─────────────────────────────────────────────
        Map<String, Object> memberMap =
                memberDao.findByEmail(user.getEmail());

        if (memberMap == null || memberMap.get("id") == null) {

            response.setStatus(HttpServletResponse.SC_NOT_FOUND);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"회원 정보를 찾을 수 없습니다.\"}"
            );

            return;
        }

        int memberId =
                ((Number) memberMap.get("id")).intValue();

        // ─────────────────────────────────────────────
        // 오늘 운동 기록 조회
        // ─────────────────────────────────────────────
        List<WorkoutLogDTO> list =
                logDao.findTodayByMemberId(memberId);

        if (list == null) {
            list = new ArrayList<>();
        }

        response.setContentType("application/json;charset=UTF-8");

        StringBuilder json = new StringBuilder("[");

        int idx = 0;

        for (WorkoutLogDTO log : list) {

            if (log == null || log.getDetails() == null) {
                continue;
            }

            for (WorkoutDetailDTO d : log.getDetails()) {

                if (d == null) {
                    continue;
                }

                if (idx > 0) {
                    json.append(",");
                }

                json.append("{")
                    .append("\"title\":\"")
                    .append(esc(d.getTitle()))
                    .append("\",")

                    .append("\"weight\":")
                    .append(d.getWeight())
                    .append(",")

                    .append("\"rep\":")
                    .append(d.getRep())
                    .append(",")

                    .append("\"set\":")
                    .append(d.getSet())

                    .append("}");

                idx++;
            }
        }

        json.append("]");

        response.getWriter().write(json.toString());
    }

    /**
     * 운동 기록 저장
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        UserDTO user =
                (UserDTO) session.getAttribute("loginUser");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // ─────────────────────────────────────────────
        // MEMBER.id 조회
        // ─────────────────────────────────────────────
        Map<String, Object> memberMap =
                memberDao.findByEmail(user.getEmail());

        if (memberMap == null || memberMap.get("id") == null) {

            response.setStatus(HttpServletResponse.SC_NOT_FOUND);

            response.getWriter().write(
                    "{\"success\":false,\"message\":\"회원 정보를 찾을 수 없습니다.\"}"
            );

            return;
        }

        int memberId =
                ((Number) memberMap.get("id")).intValue();

        // ─────────────────────────────────────────────
        // 파라미터 받기
        // ─────────────────────────────────────────────
        String title =
                request.getParameter("name");

        String wtStr =
                request.getParameter("weight");

        String rpStr =
                request.getParameter("reps");

        String setStr =
                request.getParameter("sets");

        double weight = 0;

        int reps = 0;

        int sets = 1;

        try {
            weight = Double.parseDouble(wtStr);
        } catch (Exception ignored) {}

        try {
            reps = Integer.parseInt(rpStr);
        } catch (Exception ignored) {}

        try {
            sets = Integer.parseInt(setStr);
        } catch (Exception ignored) {}

        // ─────────────────────────────────────────────
        // WorkoutLogDTO 생성
        // ─────────────────────────────────────────────
        WorkoutLogDTO dto = new WorkoutLogDTO();

        dto.setMemberId(memberId);

        dto.setDate(LocalDate.now());

        // ─────────────────────────────────────────────
        // 상세 운동 기록 생성
        // ─────────────────────────────────────────────
        if (title != null && !title.trim().isEmpty()) {

            WorkoutDetailDTO detail =
                    new WorkoutDetailDTO();

            detail.setTitle(title.trim());

            detail.setWeight(weight);

            detail.setRep(reps);

            detail.setSet(sets);

            List<WorkoutDetailDTO> details =
                    new ArrayList<>();

            details.add(detail);

            dto.setDetails(details);
        }

        // ─────────────────────────────────────────────
        // 저장
        // ─────────────────────────────────────────────
        int result = service.save(dto);

        response.setContentType("application/json;charset=UTF-8");

        if (result > 0) {

            response.getWriter().write(
                    "{\"success\":true,\"workoutId\":"
                            + dto.getId()
                            + "}"
            );

        } else {

            response.getWriter().write(
                    "{\"success\":false}"
            );
        }
    }

    /**
     * JSON escape
     */
    private String esc(String s) {

        if (s == null) {
            return "";
        }

        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }
}