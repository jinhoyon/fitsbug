package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.member.MemberDTO;
import dto.common.UserDTO;

@WebServlet("/member/step3")
public class Step3Controller extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    RequestDispatcher rd = request.getRequestDispatcher("/member/step3.jsp");
	    rd.forward(request, response);
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // ── Step1 세션 데이터 ─────────────────────────────────
        String email    = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");
        String nickname = (String) session.getAttribute("nickname");
        String name     = (String) session.getAttribute("name");
        String phone    = (String) session.getAttribute("phone");
        String ageStr   = (String) session.getAttribute("age");
        String gender   = (String) session.getAttribute("gender");

        // ── Step2 세션 데이터 ─────────────────────────────────
        String heightStr = (String) session.getAttribute("height");
        String weightStr = (String) session.getAttribute("weight");
        String dietRaw   = (String) session.getAttribute("diet");
        // Map form values to DB ENUM('YES','Intermediate','NO')
        String diet;
        if ("strict".equals(dietRaw))        diet = "YES";
        else if ("protein".equals(dietRaw))  diet = "Intermediate";
        else                                 diet = "NO";

        // ── Step3 파라미터 ────────────────────────────────────
        // step3.jsp name="purpose"  → DB ENUM('diet','balance','bulk-up')
        String purpose    = request.getParameter("purpose");
        // step3.jsp name="experience" → DB ENUM('first(0)','beginner(<1)','intermediate(1~3)','high(>3)')
        String experience = request.getParameter("experience");
        // step3.jsp name="goals" → 자유 텍스트
        String goals      = request.getParameter("goals");
        // step3.jsp name="workout" → DB ENUM('<=2','3~4','>5')
        String workout    = request.getParameter("workout");

        int height = 0, weight = 0, age = 0;
        try { height = Integer.parseInt(heightStr); } catch (Exception ignored) {}
        try { weight = Integer.parseInt(weightStr); } catch (Exception ignored) {}
        try { age    = Integer.parseInt(ageStr);    } catch (Exception ignored) {}

        UserDTO user = new UserDTO();
        user.setEmail(email);
        user.setPassword(password);
        user.setNickname(nickname);
        user.setName(name);
        user.setPhone(phone);

        user.setEmailVerified(true);

        user.setAge(age);
        user.setGender(gender);

        user.setRole("MEMBER");

        UserDAO userDao = new UserDAOImpl();
        userDao.insert(user);

        UserDTO inserted = userDao.findByEmail(email);
        int userId = (inserted != null) ? inserted.getId() : 0;


        MemberDTO member = new MemberDTO();
        member.setUserId(userId);
        member.setPurpose(purpose);           // DB: purpose ENUM
        member.setExperience(experience);     // DB: experience ENUM
        member.setHeight(height);
        member.setWeight(weight);
        member.setDiet(diet);
        member.setGoals(goals);               // ★ goals = 자유 텍스트 (버그 수정: 기존 purpose를 넣던 것 수정)
        member.setExerciseCountGoal(workout); // DB: exerciseCount_goal ENUM('<=2','3~4','>5')

        MemberDAO memberDao = new MemberDAOImpl();
        int inserted2 = memberDao.insertMember(member);
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
            session.setAttribute("loginUser",  inserted);
            session.setAttribute("loginEmail", email);

            member.setEmail(email);
            member.setNickname(nickname);
            session.setAttribute("memberInfo", member);
        }

        response.sendRedirect(request.getContextPath() + "/member/main");
    }
}