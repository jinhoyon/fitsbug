package controller.member;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dto.member.MemberDTO;
import dto.common.UserDTO;
import service.member.MyPageService;
import service.member.MyPageServiceImpl;

@WebServlet("/member/updatePlan")
public class UpdatePlanController extends HttpServlet {

    private final MyPageService myPageService = new MyPageServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.getWriter().write("not_login");
            return;
        }

        MemberDTO member = new MemberDTO();
        member.setEmail(loginUser.getEmail());
        member.setPurpose(req.getParameter("purpose"));
        member.setGoals(req.getParameter("goal"));
        member.setExperience(req.getParameter("level"));
        member.setDiet(req.getParameter("diet"));

        try {
            member.setHeight(Integer.parseInt(req.getParameter("height")));
            member.setWeight(Integer.parseInt(req.getParameter("weight")));
        } catch (NumberFormatException e) {
            member.setHeight(0);
            member.setWeight(0);
        }

        String exGoal = req.getParameter("exerciseCountGoal");
        if (exGoal != null && !exGoal.isEmpty()) {
            member.setExerciseCountGoal(exGoal);
        }

        myPageService.updateMyPage(null, member);

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
