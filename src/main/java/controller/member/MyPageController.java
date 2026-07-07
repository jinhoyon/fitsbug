package controller.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.MemberDTO;
import dto.member.MyPageDTO;
import dto.common.UserDTO;
import service.member.MyPageService;
import service.member.MyPageServiceImpl;

@WebServlet("/member/mypage")
public class MyPageController extends HttpServlet {

    private MyPageService service = new MyPageServiceImpl();

    // ── GET ───────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        request.setAttribute("tab", request.getParameter("tab"));

        // MyPageDTO.getMember() → Map<String,Object>
        MyPageDTO dto = service.getMyPage(loginUser.getEmail());
        Map<String, Object> memberMap = (dto != null) ? dto.getMember() : null;

        // null 방어
        if (memberMap == null) {
            memberMap = new HashMap<>();
            memberMap.put("email",         loginUser.getEmail());
            memberMap.put("nickname",      loginUser.getNickname());
            memberMap.put("profile_image", loginUser.getProfileImage());
            memberMap.put("role",          loginUser.getRole());
        }

        request.setAttribute("member", memberMap);
        request.getRequestDispatcher("/member/mypage.jsp").forward(request, response);
    }

    // ── POST ──────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // USER
        UserDTO user = new UserDTO();
        user.setId(loginUser.getId());
        user.setNickname(request.getParameter("nickname"));
        user.setPhone(request.getParameter("phone"));

        // MEMBER
        MemberDTO member = new MemberDTO();
        member.setEmail(loginUser.getEmail());
        member.setGoals(request.getParameter("goal"));
        member.setExperience(request.getParameter("level"));
        member.setPurpose(request.getParameter("purpose"));
        member.setDiet(request.getParameter("diet"));
        member.setExerciseCountGoal(request.getParameter("exerciseCountGoal"));
        try {
            member.setHeight(Integer.parseInt(request.getParameter("height")));
            member.setWeight(Integer.parseInt(request.getParameter("weight")));
        } catch (Exception e) {
            member.setHeight(0);
            member.setWeight(0);
        }

        service.updateMyPage(user, member);

        // 세션 동기화
        loginUser.setNickname(user.getNickname());
        loginUser.setPhone(user.getPhone());
        session.setAttribute("loginUser", loginUser);

        // memberInfo 세션: Map / MemberDTO 둘 다 가능 → instanceof 처리
        Object memberInfoObj = session.getAttribute("memberInfo");

        if (memberInfoObj instanceof Map) {
            @SuppressWarnings("unchecked")
            Map<String, Object> cached = (Map<String, Object>) memberInfoObj;
            cached.put("goals",              member.getGoals());
            cached.put("experience",         member.getExperience());
            cached.put("purpose",            member.getPurpose());
            cached.put("height",             member.getHeight());
            cached.put("weight",             member.getWeight());
            cached.put("diet",               member.getDiet());
            cached.put("exerciseCount_goal", member.getExerciseCountGoal());
            cached.put("nickname",           user.getNickname());
            session.setAttribute("memberInfo", cached);

        } else if (memberInfoObj instanceof MemberDTO) {
            MemberDTO cached = (MemberDTO) memberInfoObj;
            cached.setGoals(member.getGoals());
            cached.setExperience(member.getExperience());
            cached.setPurpose(member.getPurpose());
            cached.setHeight(member.getHeight());
            cached.setWeight(member.getWeight());
            cached.setDiet(member.getDiet());
            cached.setExerciseCountGoal(member.getExerciseCountGoal());
            cached.setNickname(user.getNickname());
            session.setAttribute("memberInfo", cached);
        }

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write("ok");
    }
}
