package controller.trainer;

import dao.trainer.ClientDAOImpl;
import dto.trainer.ClientDTO;
import dto.common.TrainerDTO;
import service.trainer.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/trainer/dashboard")
public class Dashboard extends HttpServlet {

    private final DashboardService dashboardService = new DashboardServiceImpl();
    private final ClientService clientService = new ClientServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }
        Integer lessonId = parseLessonId(request.getParameter("lessonId"));

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        DashboardData data = dashboardService.getDashboardData(lessonId, trainer.getTrainerId());

        request.setAttribute("todayDate", data.getTodayDate());
        request.setAttribute("todayLessons", data.getLessons());
        request.setAttribute("selectedLesson", data.getSelectedLesson());
        if (data.getSelectedLesson() != null) {
            ClientDTO client = clientService.getClientById(data.getSelectedLesson().getClientId());

            request.setAttribute("client", client);
        }
        request.setAttribute("notifications", data.getNotifications());
        request.setAttribute("hasSelectedLesson", data.getSelectedLesson() != null);
        request.getRequestDispatcher("/trainer/dashboard.jsp").forward(request, response);
    }

    private Integer parseLessonId(String rawLessonId) {
        if (rawLessonId == null || rawLessonId.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(rawLessonId);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}

