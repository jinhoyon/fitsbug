package controller.trainer;

import dao.member.InbodyLogDAO;
import dao.member.InbodyLogDAOImpl;
import dto.member.InbodyLogDTO;
import dto.trainer.ClientDTO;
import dto.trainer.TrainerDTO;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/trainer/clientDetail")
public class ClientDetail extends HttpServlet {

    private final ClientService  clientService  = new ClientServiceImpl();
    private final InbodyLogDAO   inbodyLogDAO   = new InbodyLogDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        int trainerId = trainer.getTrainerId();

        // 2. Get clientId
        String idParam = request.getParameter("clientId");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/trainer/clients");
            return;
        }

        try {
            int clientId = Integer.parseInt(idParam);

            // 3. Use Service (NOT DAO)
            ClientDTO client = clientService.getClientById(clientId);

            // 4. Ownership check
            if (client == null || client.getTrainerId() != trainerId) {
                response.sendRedirect(request.getContextPath() + "/trainer/clients");
                return;
            }

            // 5. Load inbody logs (newest → oldest from DAO)
            List<InbodyLogDTO> inbodyLogs = inbodyLogDAO.findByMemberId(clientId);
            if (inbodyLogs == null) inbodyLogs = new ArrayList<>();

            InbodyLogDTO latestInbody = inbodyLogs.isEmpty() ? null : inbodyLogs.get(0);

            // Chart needs chronological order (oldest → newest)
            List<InbodyLogDTO> chartLogs = new ArrayList<>(inbodyLogs);
            Collections.reverse(chartLogs);

            // Build JSON arrays for the chart
            StringBuilder weightJson  = new StringBuilder("[");
            StringBuilder muscleJson  = new StringBuilder("[");
            StringBuilder bodyFatJson = new StringBuilder("[");
            for (int i = 0; i < chartLogs.size(); i++) {
                InbodyLogDTO log = chartLogs.get(i);
                String comma = i > 0 ? "," : "";
                String date  = log.getRecordDate();
                weightJson .append(comma).append("{\"x\":\"").append(date).append("\",\"y\":").append(log.getWeight()).append("}");
                muscleJson .append(comma).append("{\"x\":\"").append(date).append("\",\"y\":").append(log.getMuscleMass()).append("}");
                bodyFatJson.append(comma).append("{\"x\":\"").append(date).append("\",\"y\":").append(log.getBodyFat()).append("}");
            }
            weightJson.append("]");
            muscleJson.append("]");
            bodyFatJson.append("]");

            // 6. Forward to JSP
            request.setAttribute("client",        client);
            request.setAttribute("latestInbody",  latestInbody);
            request.setAttribute("inbodyCount",   inbodyLogs.size());
            request.setAttribute("weightJson",    weightJson.toString());
            request.setAttribute("muscleJson",    muscleJson.toString());
            request.setAttribute("bodyFatJson",   bodyFatJson.toString());
            request.getRequestDispatcher("/trainer/clientDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Client ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}