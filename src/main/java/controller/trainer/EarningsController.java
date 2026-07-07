package controller.trainer;

import dto.trainer.TrainerDTO;
import service.trainer.EarningsService;
import service.trainer.EarningsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/trainer/earnings")
public class EarningsController extends HttpServlet {

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
        String currentMonth = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

        EarningsService.EarningsOverview overview =
                earningsService.getOverview(trainer.getTrainerId(), currentMonth);

        request.setAttribute("currentSettlement", overview.currentSettlement);
        request.setAttribute("settlementHistory", overview.settlementHistory);
        request.setAttribute("transactions", overview.transactions);
        request.setAttribute("currentMonth", overview.currentMonth);
        request.getRequestDispatcher("/trainer/earnings.jsp").forward(request, response);
    }
}
