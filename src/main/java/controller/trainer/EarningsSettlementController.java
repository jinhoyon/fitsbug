package controller.trainer;

import dto.common.TrainerDTO;
import service.trainer.EarningsService;
import service.trainer.EarningsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/trainer/earnings/settlement")
public class EarningsSettlementController extends HttpServlet {

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

        String sortBy = "month";
        String rawSort = request.getParameter("sortBy");
        if (rawSort != null) {
            switch (rawSort) {
                case "totalSales":
                case "netAmount":
                case "txCount":
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

        EarningsService.SettlementPage settlementPage = earningsService.getSettlementPage(
                trainer.getTrainerId(), page, sortBy, sortDir);

        request.setAttribute("settlementHistory", settlementPage.settlementHistory);
        request.setAttribute("currentPage", settlementPage.page);
        request.setAttribute("totalPages", settlementPage.totalPages);
        request.setAttribute("totalCount", settlementPage.totalCount);
        request.setAttribute("sortBy", settlementPage.sortBy);
        request.setAttribute("sortDir", settlementPage.sortDir);
        request.getRequestDispatcher("/trainer/earningsSettlement.jsp").forward(request, response);
    }
}
