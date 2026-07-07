package controller.trainer;

import dto.common.TrainerDTO;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/trainer/resubmitApproval")
public class ResubmitApprovalController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        TrainerService trainerService = new TrainerServiceImpl();

        if (trainer == null || !"REJECTED".equals(trainer.getApprovalStatus())) {
            response.sendRedirect(request.getContextPath() + "/trainer/profileEdit");
            return;
        }

        trainerService.resetApprovalStatusToPending(trainer.getTrainerId());
        response.sendRedirect(request.getContextPath() + "/trainer/profileEdit?resubmitted=1");
    }
}
