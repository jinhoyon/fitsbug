package controller.gym;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.TrainerAssign;
import dto.gym.TrainerList;
import dto.common.UserDTO;
import service.gym.GymTrainerManageService;
import service.gym.GymTrainerManageServiceImpl;

/**
 * Servlet implementation class GymTrainerManage
 */
@WebServlet("/gym/trainer")
public class TrainerManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public TrainerManageController() {
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

		GymTrainerManageService service = new GymTrainerManageServiceImpl();

		

		String keyword = request.getParameter("keyword");
		if (keyword == null) {
			keyword = "";
		}

		try {
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = user.getOtherId();

			List<TrainerList> trainerList = service.getTrainerList(gymId, keyword);
			List<TrainerAssign> assignList = service.getTrainerAssignList(gymId);

			if (trainerList == null) {
				trainerList = new ArrayList<>();
			}

			if (assignList == null) {
				assignList = new ArrayList<>();
			}

			request.setAttribute("trainerList", trainerList);
			request.setAttribute("assignList", assignList);
			request.setAttribute("keyword", keyword);

			request.getRequestDispatcher("/gym/gym_trainerManage.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException("트레이너 관리 페이지 조회 중 오류", e);
		}

	}

}
