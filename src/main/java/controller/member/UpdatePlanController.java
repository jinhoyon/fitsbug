package controller.member;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.member.MyPageDAO;
import dao.member.MyPageDAOImpl;
import dto.member.MemberDTO;
import dto.common.UserDTO;

@WebServlet("/member/updatePlan")
public class UpdatePlanController extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        // ✅ UserDTO 로 세션 조회 (MemberDTO 캐스팅 에러 수정)
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.getWriter().write("not_login");
            return;
        }

        /*
         * ✅ WorkoutPlanDAO 완전 제거
         *    운동 계획 수정 → MemberDAO(MyPageDAO).updateMemberPlan 으로 교체
         *    MEMBER 테이블에서 height/weight/diet/goals/experience 직접 UPDATE
         */
        MemberDTO member = new MemberDTO();
        member.setEmail(loginUser.getEmail());
        member.setPurpose(req.getParameter("purpose"));        // ENUM: diet/balance/bulk-up
        member.setGoals(req.getParameter("goal"));             // 자유 텍스트
        member.setExperience(req.getParameter("level"));       // ENUM: first(0)/beginner(<1)/...
        member.setDiet(req.getParameter("diet"));              // ENUM: YES/Intermediate/NO

        try {
            member.setHeight(Integer.parseInt(req.getParameter("height")));
            member.setWeight(Integer.parseInt(req.getParameter("weight")));
        } catch (NumberFormatException e) {
            member.setHeight(0);
            member.setWeight(0);
        }

        String exGoal = req.getParameter("exerciseCountGoal"); // ENUM: <=2/3~4/>5
        if (exGoal != null && !exGoal.isEmpty()) {
            member.setExerciseCountGoal(exGoal);
        }

        MyPageDAO dao = new MyPageDAOImpl();
        dao.updateMemberPlan(member);

        // 세션 memberInfo 최신화
        MemberDTO cached = (MemberDTO) session.getAttribute("memberInfo");
        if (cached != null) {
            cached.setGoals(member.getGoals());
            cached.setExperience(member.getExperience());
            cached.setHeight(member.getHeight());
            cached.setWeight(member.getWeight());
            cached.setDiet(member.getDiet());
            session.setAttribute("memberInfo", cached);
        }

        resp.getWriter().write("ok");
    }
}
