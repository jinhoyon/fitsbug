package controller.gym;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.Dashboard;
import service.gym.GymDashboardService;
import service.gym.GymDashboardServiceImpl;

@WebServlet("/gym/dashboard")
public class GymDashboard extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymDashboard() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("gymId") == null ||
        	    session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        Integer gymId = (Integer) session.getAttribute("gymId");

        String weekStart = request.getParameter("weekStart");
        
        if (weekStart == null || weekStart.trim().isEmpty()) {
            weekStart = java.time.LocalDate.now().toString();
        }
        
        String selectedDate = request.getParameter("selectedDate");

        LocalDate date;

        if (selectedDate == null || selectedDate.isEmpty()) {
            date = LocalDate.now();
            selectedDate = date.toString();
        } else {
            date = LocalDate.parse(selectedDate);
        }

        String selectedDay = date.getDayOfWeek().toString().substring(0, 3);
        request.setAttribute("selectedDay", selectedDay);

        try {
            GymDashboardService service = new GymDashboardServiceImpl();

            Dashboard dashboard = service.getDashboard(gymId, weekStart, selectedDate);

            dashboard.setTodayDate(date.toString());
            
            dashboard.setWeekStart(weekStart);

            request.setAttribute("dashboard", dashboard);

            request.getRequestDispatcher("/gym/gym_dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("msg", "대시보드 조회 중 오류가 발생했습니다.");
            request.setAttribute("url", request.getContextPath() + "/gym/dashboard");

            request.getRequestDispatcher("/common/alert.jsp")
                   .forward(request, response);
        }
    }
}