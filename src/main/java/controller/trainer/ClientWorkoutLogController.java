package controller.trainer;

import dto.member.WorkoutDetailDTO;
import dto.member.WorkoutLogDTO;
import dto.trainer.ClientDTO;
import dto.trainer.TrainerDTO;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;
import service.trainer.WorkoutService;
import service.trainer.WorkoutServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalTime;
import java.util.*;

@WebServlet("/trainer/clientWorkoutLog")
public class ClientWorkoutLogController extends HttpServlet {

    private final ClientService  clientService  = new ClientServiceImpl();
    private final WorkoutService workoutService = new WorkoutServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        int trainerId = trainer.getTrainerId();

        String idParam = request.getParameter("clientId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/trainer/clients");
            return;
        }

        try {
            int clientId = Integer.parseInt(idParam);

            ClientDTO client = clientService.getClientById(clientId);
            if (client == null || client.getTrainerId() != trainerId) {
                response.sendRedirect(request.getContextPath() + "/trainer/clients");
                return;
            }

            List<WorkoutLogDTO> rawLogs = workoutService.getAllLogsByClientId(clientId);
            if (rawLogs == null) rawLogs = new ArrayList<>();

            List<Map<String, Object>> logs = new ArrayList<>();
            for (WorkoutLogDTO log : rawLogs) {
                Map<String, Object> m = new LinkedHashMap<>();
                m.put("id",        log.getId());
                m.put("date",      log.getDate() != null ? log.getDate().toString() : "");
                m.put("startTime", fmtTime(log.getStartTime()));
                m.put("endTime",   fmtTime(log.getEndTime()));
                m.put("details",   log.getDetails() != null ? log.getDetails() : new ArrayList<WorkoutDetailDTO>());
                logs.add(m);
            }

            request.setAttribute("client",      client);
            request.setAttribute("workoutLogs", logs);
            request.getRequestDispatcher("/trainer/clientWorkoutLog.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Client ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String fmtTime(LocalTime t) {
        if (t == null) return "";
        String s = t.toString();
        return s.length() >= 5 ? s.substring(0, 5) : s;
    }
}
