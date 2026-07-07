package controller.trainer;

import dto.trainer.TrainerDTO;
import service.trainer.EarningsService;
import service.trainer.EarningsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/trainer/earnings/transactions")
public class EarningsTransactionsController extends HttpServlet {

    private final EarningsService earningsService = new EarningsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {
        }

        String sortBy = "date";
        String rawSort = request.getParameter("sortBy");
        if (rawSort != null) {
            switch (rawSort) {
                case "clientName":
                case "price":
                case "netAmount":
                case "status":
                    sortBy = rawSort;
                    break;
                default:
                    break;
            }
        }

        String sortDir = "DESC";
        if ("ASC".equalsIgnoreCase(request.getParameter("sortDir"))) {
            sortDir = "ASC";
        }

        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        if (dateFrom != null && !dateFrom.matches("\\d{4}-\\d{2}-\\d{2}")) {
            dateFrom = null;
        }
        if (dateTo != null && !dateTo.matches("\\d{4}-\\d{2}-\\d{2}")) {
            dateTo = null;
        }

        EarningsService.TransactionsPage transactionsPage = earningsService.getTransactionsPage(
                trainer.getTrainerId(), page, sortBy, sortDir, dateFrom, dateTo);

        request.setAttribute("transactions", transactionsPage.transactions);
        request.setAttribute("currentPage", transactionsPage.page);
        request.setAttribute("totalPages", transactionsPage.totalPages);
        request.setAttribute("totalCount", transactionsPage.totalCount);
        request.setAttribute("sortBy", transactionsPage.sortBy);
        request.setAttribute("sortDir", transactionsPage.sortDir);
        request.setAttribute("dateFrom", transactionsPage.dateFrom != null ? transactionsPage.dateFrom : "");
        request.setAttribute("dateTo", transactionsPage.dateTo != null ? transactionsPage.dateTo : "");
        request.getRequestDispatcher("/trainer/earningsTransactions.jsp").forward(request, response);
    }
}
