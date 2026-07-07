package controller.gym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.TrainerMemberView;
import dto.common.UserDTO;
import service.gym.GymTrainerManageService;
import service.gym.GymTrainerManageServiceImpl;

@WebServlet("/gym/trainerMembers")
public class GymTrainerMembers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymTrainerMembers() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        

        String trainerIdStr = request.getParameter("trainerId");

        if (trainerIdStr == null || trainerIdStr.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("[]");
            return;
        }

        int trainerId;

        try {
        	
            trainerId = Integer.parseInt(trainerIdStr);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("[]");
            return;
        }

        String type = request.getParameter("type");
        if (type == null || type.isEmpty()) {
            type = "current";
        }

        try {
        	HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = user.getOtherId();

            GymTrainerManageService service = new GymTrainerManageServiceImpl();

            List<TrainerMemberView> list = service.getMembers(trainerId, gymId, type);

            if (list == null) {
                list = java.util.Collections.emptyList();
            }

            PrintWriter out = response.getWriter();
            StringBuilder json = new StringBuilder();

            json.append("[");

            for (int i = 0; i < list.size(); i++) {
                TrainerMemberView m = list.get(i);

                json.append("{");
                json.append("\"memberId\":").append(m.getMemberId()).append(",");
                json.append("\"memberName\":\"").append(jsonEscape(m.getMemberName())).append("\",");
                json.append("\"membershipName\":\"").append(jsonEscape(m.getMembershipName())).append("\",");
                json.append("\"remainingSession\":").append(m.getRemainingSession()).append(",");
                json.append("\"startDate\":\"")
                .append(m.getStartDate() == null ? "" : m.getStartDate().toLocalDateTime().toLocalDate())
                .append("\"");
                json.append("}");

                if (i < list.size() - 1) {
                    json.append(",");
                }
            }

            json.append("]");

            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }

    private String jsonEscape(String value) {
        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}