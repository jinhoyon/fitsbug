package controller.trainer;

import dto.trainer.TrainerDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/trainer/earnings")
public class EarningsController extends HttpServlet {

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
        String currentMonth = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));

        Map<String, Object> currentSettlement = null;
        List<Map<String, Object>> settlementHistory = new ArrayList<>();
        List<Map<String, Object>> transactions = new ArrayList<>();

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {

            // 1. Current month aggregated from PAYMENT
            try {
                Map<String, Object> param = new HashMap<>();
                param.put("trainerId", trainerId);
                param.put("month", currentMonth);
                currentSettlement = sql.selectOne("mapper.trainer.settlement.findCurrentMonth", param);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // 2. Last 12 months aggregated from PAYMENT
            try {
                settlementHistory = sql.selectList("mapper.trainer.settlement.findAllByTrainer", trainerId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            // 3. All transactions with settlementMonth (for chart bar click filtering)
            try {
                transactions = sql.selectList("mapper.PaymentMapper.findAllByTrainerId", trainerId);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("currentSettlement", currentSettlement);
        request.setAttribute("settlementHistory", settlementHistory);
        request.setAttribute("transactions", transactions);
        request.setAttribute("currentMonth", currentMonth);
        request.getRequestDispatcher("/trainer/earnings.jsp").forward(request, response);
    }
}
