package controller.gym;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.gym.Payment;
import dto.member.UserDTO;
import service.gym.GymPaymentService;
import service.gym.GymPaymentServiceImpl;

@WebServlet("/gym/payment/*")
public class GymPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GymPayment() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		GymPaymentService paymentService = new GymPaymentServiceImpl();

		String path = request.getPathInfo();

		try {
			if ("/complete".equals(path)) {
				
				HttpSession session = request.getSession();
				UserDTO user = (UserDTO)session.getAttribute("loginUser");
		        if (user == null) {
		            response.sendRedirect(request.getContextPath() + "/member/login");
		            return;
		        } 

		        Integer gymId = user.getOtherId();

				int membershipNum = Integer.parseInt(request.getParameter("membershipId"));
				String startDateStr = request.getParameter("startDate");

				if (startDateStr == null || startDateStr.trim().isEmpty()) {
					response.sendError(HttpServletResponse.SC_BAD_REQUEST, "startDate 없음");
					return;
				}

				Membership membership = paymentService.getMembership(membershipNum);

				if (membership == null) {
					response.sendRedirect(request.getContextPath() + "/gym/main?gymId=" + gymId);
					return;
				}

				LocalDate startLocalDate = LocalDate.parse(startDateStr, DateTimeFormatter.ISO_DATE);
				LocalDate endLocalDate;

				if ("day".equals(membership.getType())) {
					endLocalDate = startLocalDate.plusDays(membership.getTypeRep() - 1);
				} else if ("month".equals(membership.getType())) {
					endLocalDate = startLocalDate.plusMonths(membership.getTypeRep());
				} else {
					throw new ServletException("헬스장 이용권 결제에서는 day/month 타입만 처리 가능합니다.");
				}

				MembershipRegistration mr = new MembershipRegistration();
				mr.setMemberNum(user.getOtherId());
				mr.setMembershipNum(membershipNum);
				mr.setGymId(membership.getGymNum());
				mr.setTrainerId(null);
				mr.setStartDate(Date.valueOf(startLocalDate));
				mr.setEndDate(Date.valueOf(endLocalDate));
				mr.setStatus("active");

				Payment payment = new Payment();
				payment.setUserId(user.getId());
				payment.setUserName(user.getName());
				payment.setMembershipNum(membershipNum);
				payment.setGymId(membership.getGymNum());
				payment.setTrainerId(null);
				payment.setPaymentPrice(membership.getPrice());
				payment.setPaymentFee(BigDecimal.ZERO);
				payment.setMethod("PORTONE");
				payment.setStatus("결제완료");
				payment.setPaymentType("MEMBERSHIP");

				paymentService.registerMembershipAndPayment(mr, payment);

				response.sendRedirect(request.getContextPath() + "/gym/main?gymId=" + membership.getGymNum());
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}

		response.sendRedirect(request.getContextPath() + "/gym/main");
	}
}