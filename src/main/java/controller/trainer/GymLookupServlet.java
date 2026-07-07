package controller.trainer;

import dto.common.Gym;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/trainer/gymLookup")
public class GymLookupServlet extends HttpServlet {

    private final TrainerService trainerService = new TrainerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        String gymCode = request.getParameter("code");
        if (gymCode == null || gymCode.trim().isEmpty()) {
            response.getWriter().write("{\"found\":false}");
            return;
        }

        Integer gymId = trainerService.findGymIdByGymCode(gymCode.trim());
        if (gymId == null) {
            response.getWriter().write("{\"found\":false}");
            return;
        }

        Gym gym = trainerService.getGymInfoById(gymId);
        if (gym == null) {
            response.getWriter().write("{\"found\":false}");
            return;
        }

        String name          = escape(gym.getName());
        String address       = escape(gym.getAddress());
        String addressDetail = escape(gym.getAddressDetail());
        String postcode      = escape(gym.getPostcode());
        String lat           = gym.getLatitude()  != null ? gym.getLatitude().toPlainString()  : "";
        String lng           = gym.getLongitude() != null ? gym.getLongitude().toPlainString() : "";

        response.getWriter().write(
            "{\"found\":true," +
            "\"name\":\"" + name + "\"," +
            "\"address\":\"" + address + "\"," +
            "\"addressDetail\":\"" + addressDetail + "\"," +
            "\"postcode\":\"" + postcode + "\"," +
            "\"latitude\":\"" + lat + "\"," +
            "\"longitude\":\"" + lng + "\"}"
        );
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
