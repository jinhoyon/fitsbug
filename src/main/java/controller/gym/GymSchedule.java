package controller.gym;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.UserDTO;
import service.gym.GymScheduleService;
import service.gym.GymScheduleServiceImpl;

/**
 * Servlet implementation class GymSchedule
 */
@WebServlet("/gym/schedule")
public class GymSchedule extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GymSchedule() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		try {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = user.getOtherId();


			String weekOffsetStr = request.getParameter("weekOffset");

			int weekOffset = 0;
			if (weekOffsetStr != null && !weekOffsetStr.trim().isEmpty()) {
				weekOffset = Integer.parseInt(weekOffsetStr);
			}

			GymScheduleService service = new GymScheduleServiceImpl();

			Map<String, Object> data = service.getSchedulePageData(gymId, weekOffset);

			request.setAttribute("trainerList", data.get("trainerList"));
			request.setAttribute("dayList", data.get("dayList"));
			request.setAttribute("hourList", data.get("hourList"));
			request.setAttribute("scheduleMap", data.get("scheduleMap"));
			request.setAttribute("weekRangeText", data.get("weekRangeText"));
			request.setAttribute("weekOffset", weekOffset);

			request.getRequestDispatcher("/gym/gym_schedule.jsp").forward(request, response);

		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/gym/schedule");

		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}

}
