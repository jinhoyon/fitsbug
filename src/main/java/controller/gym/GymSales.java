package controller.gym;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.common.UserDTO;
import service.gym.GymSalesService;
import service.gym.GymSalesServiceImpl;

/**
 * Servlet implementation class GymSales
 */
@WebServlet("/gym/sales")
public class GymSales extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GymSales() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GymSalesService service = new GymSalesServiceImpl();
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


            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String membershipType = request.getParameter("membershipType");
            String trainerId = request.getParameter("trainerId");
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            
            if (startDate == null || startDate.isBlank()) {
                startDate = LocalDate.now().withDayOfMonth(1).toString();
            }

            if (endDate == null || endDate.isBlank()) {
                endDate = LocalDate.now().toString();
            }
            
            int page = 1;
            int pageSize = 10;

            String pageParam = request.getParameter("page");

            try {
                if (pageParam != null && !pageParam.isBlank()) {
                    page = Integer.parseInt(pageParam);
                }
            } catch (NumberFormatException e) {
                page = 1;
            }

            if (page < 1) {
                page = 1;
            }

            int startRow = (page - 1) * pageSize;
            
            Map<String, Object> param = new HashMap<>();
            param.put("gymNum", gymId);
            param.put("startDate", startDate);
            param.put("endDate", endDate);
            param.put("membershipType", membershipType);
            param.put("trainerId", trainerId);
            param.put("status", status);
            param.put("keyword", keyword);
            param.put("startRow", startRow);
            param.put("pageSize", pageSize);
            
            int totalCount = service.getSalesCount(param);
            int totalPage = (int) Math.ceil((double) totalCount / pageSize);
            if (totalPage == 0) {
                totalPage = 1;
            }
            
            request.setAttribute("salesList", service.getSalesList(param));
            request.setAttribute("salesSummary", service.getSalesSummary(param));
            request.setAttribute("salesChartList", service.getSalesChartList(param));
            request.setAttribute("topTrainerList", service.getTopTrainerList(param));
            request.setAttribute("trainerList", service.getTrainerList(gymId));

            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("membershipType", membershipType);
            request.setAttribute("trainerId", trainerId);
            request.setAttribute("status", status);
            request.setAttribute("keyword", keyword);

            request.setAttribute("totalCount", totalCount);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("currentPage", page);
            
            request.getRequestDispatcher("/gym/gym_sales.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}
}
