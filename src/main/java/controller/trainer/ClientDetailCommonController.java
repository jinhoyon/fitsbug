package controller.trainer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.InbodyLogDTO;
import dto.trainer.ClientDTO;
import service.member.InbodyLogService;
import service.member.InbodyLogServiceImpl;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;

/**
 * Servlet implementation class ClientDetailCommon
 */
@WebServlet("/trainer/clientDetailCommon")
public class ClientDetailCommonController extends HttpServlet {

    private final ClientService clientService = new ClientServiceImpl();
    private final InbodyLogService inbodyLogService = new InbodyLogServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session check (gym/admin also use this view)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        // 2. Get clientId
        String idParam = request.getParameter("clientId");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/member/main");
            return;
        }

        try {
            int clientId = Integer.parseInt(idParam);

            // 3. Use Service (NOT DAO)
            ClientDTO client = clientService.getClientById(clientId);

            if (client == null) {
                response.sendRedirect(request.getContextPath() + "/member/main");
                return;
            }

            // 5. Load inbody logs (newest → oldest from DAO)
            List<InbodyLogDTO> inbodyLogs = inbodyLogService.getListByMemberId(clientId);
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
            request.getRequestDispatcher("/trainer/clientDetailCommon.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Client ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}