package controller.gym;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.MemberManage;
import dto.gym.Payment;
import dto.member.UserDTO;
import service.gym.GymMemberManageService;
import service.gym.GymMemberManageServiceImpl;
import service.gym.GymPaymentService;
import service.gym.GymPaymentServiceImpl;

/**
 * Servlet implementation class GymMemberManage
 */
@WebServlet("/gym/memberManage")
public class GymMemberManage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GymMemberManage() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 try {
			 HttpSession session = request.getSession();
				UserDTO user = (UserDTO)session.getAttribute("loginUser");
	            if (user == null) {
	                response.sendRedirect(request.getContextPath() + "/member/login");
	                return;
	            }

	            Integer gymId = user.getOtherId();
	            System.out.println("회원관리 gymId = " + gymId);
	            System.out.println("loginUser = " + user);
	            
		        String keyword = request.getParameter("keyword");
		        String type = request.getParameter("type");
		        String status = request.getParameter("status");

		        int page = request.getParameter("page") == null ? 1 :
		                   Integer.parseInt(request.getParameter("page"));

		        int pageSize = 5;
		        int start = (page - 1) * pageSize;

		        GymMemberManageService service = new GymMemberManageServiceImpl();
		        GymPaymentService paymentService = new GymPaymentServiceImpl();

		        Map<String, Object> param = new HashMap<>();
		        param.put("gymId", gymId);
		        param.put("keyword", keyword);
		        param.put("type", type);
		        param.put("status", status);
		        param.put("start", start);
		        param.put("pageSize", pageSize);

		        List<MemberManage> memberList = service.getMemberList(param);
		        int totalMemberCount = service.getMemberListCount(param);
		        int newMemberCount = service.getNewMemberCount(gymId);

		        int totalPage = (int) Math.ceil((double) totalMemberCount / pageSize);

		        List<Payment> paymentList = paymentService.selectRefundRequestList(gymId);
		        int pendingRefundCount = paymentService.countRefundRequest(gymId);
		        
		        request.setAttribute("memberList", memberList);
		        request.setAttribute("totalMemberCount", totalMemberCount);
		        request.setAttribute("newMemberCount", newMemberCount);
		        request.setAttribute("page", page);
		        request.setAttribute("pageSize", pageSize);
		        request.setAttribute("totalPage", totalPage);

		        request.setAttribute("paymentList", paymentList);
		        request.setAttribute("pendingRefundCount", pendingRefundCount);

		        request.setAttribute("keyword", keyword);
		        request.setAttribute("type", type);
		        request.setAttribute("status", status);
		        
		        request.getRequestDispatcher("/gym/gym_memberManage.jsp")
		               .forward(request, response);

		    } catch (Exception e) {
		        e.printStackTrace();
		        throw new ServletException(e);
		    }
	}
}
