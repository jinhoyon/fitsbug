package controller.trainer;

import dto.trainer.TrainerDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer/earnings/transactions")
public class EarningsTransactionsController extends HttpServlet {

    private static final int PAGE_SIZE = 20;

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

        int page = 1;
        try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}
        if (page < 1) page = 1;

        // Whitelist sortBy to prevent SQL injection (used via ${} in MyBatis)
        String sortBy = "date";
        String rawSort = request.getParameter("sortBy");
        if (rawSort != null) {
            switch (rawSort) {
                case "clientName": case "price": case "netAmount": case "status":
                    sortBy = rawSort; break;
            }
        }
        String sortDir = "DESC";
        if ("ASC".equalsIgnoreCase(request.getParameter("sortDir"))) sortDir = "ASC";

        String dateFrom = request.getParameter("dateFrom");
        String dateTo   = request.getParameter("dateTo");
        // Basic validation: must be yyyy-MM-dd or empty
        if (dateFrom != null && !dateFrom.matches("\\d{4}-\\d{2}-\\d{2}")) dateFrom = null;
        if (dateTo   != null && !dateTo  .matches("\\d{4}-\\d{2}-\\d{2}")) dateTo   = null;

        int totalCount = 0;
        List<Map<String, Object>> transactions = new ArrayList<>();

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            try {
                Map<String, Object> countParam = new HashMap<>();
                countParam.put("trainerId", trainerId);
                countParam.put("dateFrom",  dateFrom);
                countParam.put("dateTo",    dateTo);
                totalCount = sql.selectOne("mapper.PaymentMapper.countByTrainerId", countParam);
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                Map<String, Object> param = new HashMap<>();
                param.put("trainerId", trainerId);
                param.put("limit",     PAGE_SIZE);
                param.put("offset",    (page - 1) * PAGE_SIZE);
                param.put("sortBy",    sortBy);
                param.put("sortDir",   sortDir);
                param.put("dateFrom",  dateFrom);
                param.put("dateTo",    dateTo);
                transactions = sql.selectList("mapper.PaymentMapper.findByTrainerIdPaged", param);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        request.setAttribute("transactions", transactions);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortDir", sortDir);
        request.setAttribute("dateFrom", dateFrom != null ? dateFrom : "");
        request.setAttribute("dateTo",   dateTo   != null ? dateTo   : "");
        request.getRequestDispatcher("/trainer/earningsTransactions.jsp").forward(request, response);
    }
}
