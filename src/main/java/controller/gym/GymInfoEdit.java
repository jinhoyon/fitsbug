package controller.gym;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.member.UserDTO;
import service.gym.GymInfoEditService;
import service.gym.GymInfoEditServiceImpl;

@WebServlet("/gym/infoEdit")
public class GymInfoEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymInfoEdit() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        
        try {
        	
        	HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("gymId") == null ||
            	    session.getAttribute("loginUser") == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = (Integer) session.getAttribute("gymId");
            UserDTO user = (UserDTO) session.getAttribute("loginUser");

            GymInfoEditService gymservice = new GymInfoEditServiceImpl();
            Gym gym = gymservice.selectGymMypage(gymId);
            
            Schedule schedule = gymservice.selectSchedule(gymId);
            List<Membership> membershipList = gymservice.selectMembershipList(gymId);

            request.setAttribute("gym", gym);
            request.setAttribute("schedule", schedule);
            request.setAttribute("membershipList", membershipList);
            request.setAttribute("user", user);

            request.getRequestDispatcher("/gym/gym_infoEdit.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("msg", "헬스장 정보 수정 페이지 조회 중 오류가 발생했습니다.");
            request.setAttribute("url", request.getContextPath() + "/gym/infoEdit");

            request.getRequestDispatcher("/common/alert.jsp")
                   .forward(request, response);
        }
    }
}