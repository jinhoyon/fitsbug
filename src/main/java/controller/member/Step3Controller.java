package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dto.member.MemberDTO;
import dto.common.UserDTO;
import service.member.MemberService;
import service.member.MemberServiceImpl;
import service.member.UserService;
import service.member.UserServiceImpl;
import util.PasswordUtil;

@WebServlet("/member/step3")
public class Step3Controller extends HttpServlet {

    private final UserService userService = new UserServiceImpl();
    private final MemberService memberService = new MemberServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/member/step3.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String email    = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");
        String nickname = (String) session.getAttribute("nickname");
        String name     = (String) session.getAttribute("name");
        String phone    = (String) session.getAttribute("phone");
        String ageStr   = (String) session.getAttribute("age");
        String gender   = (String) session.getAttribute("gender");

        String heightStr = (String) session.getAttribute("height");
        String weightStr = (String) session.getAttribute("weight");
        String dietRaw   = (String) session.getAttribute("diet");
        String diet;
        if ("strict".equals(dietRaw))        diet = "YES";
        else if ("protein".equals(dietRaw))  diet = "Intermediate";
        else                                 diet = "NO";

        String purpose    = request.getParameter("purpose");
        String experience = request.getParameter("experience");
        String goals      = request.getParameter("goals");
        String workout    = request.getParameter("workout");

        int height = 0, weight = 0, age = 0;
        try { height = Integer.parseInt(heightStr); } catch (Exception ignored) {}
        try { weight = Integer.parseInt(weightStr); } catch (Exception ignored) {}
        try { age    = Integer.parseInt(ageStr);    } catch (Exception ignored) {}

        UserDTO user = new UserDTO();
        user.setEmail(email);
        user.setPassword(PasswordUtil.hash(password));
        user.setNickname(nickname);
        user.setName(name);
        user.setPhone(phone);
        user.setEmailVerified(true);
        user.setAge(age);
        user.setGender(gender);
        user.setRole("MEMBER");

        if (userService.register(user) <= 0) {
            request.getRequestDispatcher("/member/step3.jsp").forward(request, response);
            return;
        }

        UserDTO inserted = userService.findByEmail(email);
        int userId = (inserted != null) ? inserted.getId() : 0;

        MemberDTO member = new MemberDTO();
        member.setUserId(userId);
        member.setPurpose(purpose);
        member.setExperience(experience);
        member.setHeight(height);
        member.setWeight(weight);
        member.setDiet(diet);
        member.setGoals(goals);
        member.setExerciseCountGoal(workout);

        int inserted2 = memberService.insertMember(member);
        if (inserted2 == 0) {
            System.err.println("[Step3] MEMBER INSERT failed for user_id=" + userId);
            request.getRequestDispatcher("/member/step3.jsp").forward(request, response);
            return;
        }

        for (String key : new String[]{
                "username","password","nickname","name","phone","age","gender",
                "role","height","weight","diet",
                "authCode","authTime","authEmail"}) {
            session.removeAttribute(key);
        }

        if (inserted != null) {
            session.setAttribute("loginUser", inserted);
            session.setAttribute("loginEmail", email);
            member.setEmail(email);
            member.setNickname(nickname);
            session.setAttribute("memberInfo", member);
        }

        response.sendRedirect(request.getContextPath() + "/member/main");
    }
}
