package controller.trainer;

import dto.trainer.UserDTO;
import dto.trainer.TrainerDTO;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/trainer/profile")
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        TrainerService trainerService = new TrainerServiceImpl();
        TrainerDTO trainer = trainerService.getTrainerByUserId(loginUser.getId());

        if (trainer != null) {
            int tid = trainer.getTrainerId();
            request.setAttribute("trainer", trainer);
            request.setAttribute("specializations", trainerService.getSpecializationsByTrainerId(tid));
            request.setAttribute("traits",           trainerService.getTraitsByTrainerId(tid));
            request.setAttribute("certifications",   trainerService.getCertificationsByTrainerId(tid));
            request.setAttribute("pricing",          trainerService.getPricingByTrainerId(tid));
            request.setAttribute("availability",     trainerService.getAvailabilityByTrainerId(tid));
            if (trainer.getGymId() != null && trainer.getGymId() > 0) {
                dto.gym.Gym gym = trainerService.getGymInfoById(trainer.getGymId());
                request.setAttribute("gym", gym);
            }
        }

        request.getRequestDispatcher("/trainer/profile.jsp").forward(request, response);
    }
}
