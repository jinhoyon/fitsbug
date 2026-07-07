package controller.trainer;

import dao.member.InbodyLogDAO;
import dao.member.InbodyLogDAOImpl;
import dto.member.InbodyLogDTO;
import dto.trainer.TrainerDTO;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;
import dto.trainer.ClientDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/trainer/clientInbodyLog")
public class ClientInbodyLogController extends HttpServlet {

    private final ClientService  clientService  = new ClientServiceImpl();
    private final InbodyLogDAO   inbodyLogDAO   = new InbodyLogDAOImpl();

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

            // Ownership check
            ClientDTO client = clientService.getClientById(clientId);
            if (client == null || client.getTrainerId() != trainerId) {
                response.sendRedirect(request.getContextPath() + "/trainer/clients");
                return;
            }

            // Fetch inbody logs newest → oldest
            List<InbodyLogDTO> rawLogs = inbodyLogDAO.findByMemberId(clientId);
            if (rawLogs == null) rawLogs = new ArrayList<>();

            // Build enriched map list (DTO fields + calculated deltas)
            List<Map<String, Object>> rows = new ArrayList<>();
            for (int i = 0; i < rawLogs.size(); i++) {
                InbodyLogDTO cur  = rawLogs.get(i);
                InbodyLogDTO prev = (i + 1 < rawLogs.size()) ? rawLogs.get(i + 1) : null;

                Map<String, Object> row = new HashMap<>();
                row.put("recordDate", cur.getRecordDate());
                row.put("weight",     cur.getWeight());
                row.put("muscleMass", cur.getMuscleMass());
                row.put("bodyFat",    cur.getBodyFat());
                row.put("img",        cur.getImg());

                double weight = cur.getWeight();
                double muscle = cur.getMuscleMass();
                double fat    = cur.getBodyFat();
                double fatPct = weight > 0 ? round1(fat / weight * 100) : 0.0;
                row.put("fatPct", fatPct);

                if (prev != null) {
                    double pw      = prev.getWeight();
                    double pm      = prev.getMuscleMass();
                    double pf      = prev.getBodyFat();
                    double pFatPct = pw > 0 ? round1(pf / pw * 100) : 0.0;

                    row.put("weightDelta",  round1(weight - pw));
                    row.put("muscleDelta",  round1(muscle - pm));
                    row.put("fatDelta",     round1(fat    - pf));
                    row.put("fatPctDelta",  round1(fatPct - pFatPct));
                } else {
                    row.put("weightDelta",  null);
                    row.put("muscleDelta",  null);
                    row.put("fatDelta",     null);
                    row.put("fatPctDelta",  null);
                }

                rows.add(row);
            }

            request.setAttribute("client",      client);
            request.setAttribute("inbodyRows",   rows);
            request.setAttribute("recordCount",  rawLogs.size());
            request.getRequestDispatcher("/trainer/clientInbodyLog.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Client ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private double round1(double v) {
        return Math.round(v * 10.0) / 10.0;
    }
}
