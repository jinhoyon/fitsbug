package controller.gym;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.gym.Payment;
import dto.gym.TossPayment;
import dto.member.UserDTO;
import service.gym.GymPaymentService;
import service.gym.GymPaymentServiceImpl;
import service.gym.GymTossPaymentService;
import service.gym.GymTossPaymentServiceImpl;

/**
 * Servlet implementation class GymTossPayment
 */
@WebServlet("/gym/tossPayment")
public class GymTossPayment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GymTossPayment() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		
		try {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("loginUser");
			if (user == null) {
				response.getWriter().write("{\"success\":false, \"message\":\"로그인이 필요합니다.\"}");
				return;
			}

			String paymentKey = request.getParameter("paymentKey");
			String orderId = request.getParameter("orderId");
			String amountStr = request.getParameter("amount");
			String status = request.getParameter("status");
			
			String membershipNumStr = request.getParameter("membershipNum");
            String startDateStr = request.getParameter("startDate");

			if (paymentKey == null || orderId == null || amountStr == null) {
				response.getWriter().write("{\"success\":false, \"message\":\"결제 정보가 부족합니다.\"}");
				return;
			}
			
			int membershipNum = Integer.parseInt(membershipNumStr);
            long amount = Long.parseLong(amountStr);
            
            GymTossPaymentService tossService = new GymTossPaymentServiceImpl();
            GymPaymentService paymentService = new GymPaymentServiceImpl();

			TossPayment tossPayment = new TossPayment();
			tossPayment.setUserId(user.getId());
			tossPayment.setPaymentKey(paymentKey);
			tossPayment.setOrderId(orderId);
			tossPayment.setAmount(Long.parseLong(amountStr));
			tossPayment.setStatus(status != null ? status : "DONE");
			
			tossService.insertTossPayment(tossPayment);

			Membership membership = paymentService.getMembership(membershipNum);

            if (membership == null) {
                response.getWriter().write("{\"success\":false, \"message\":\"멤버십 정보를 찾을 수 없습니다.\"}");
                return;
            }

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = calculateEndDate(startDate, membership);

            MembershipRegistration membershipRegistration = new MembershipRegistration();
            membershipRegistration.setMemberNum(user.getOtherId()); // MEMBER.id
            membershipRegistration.setMembershipNum(membershipNum);
            membershipRegistration.setGymId(membership.getGymNum());
            membershipRegistration.setTrainerId(membership.getTrainerNum());
            membershipRegistration.setStartDate(Date.valueOf(startDate));
            membershipRegistration.setEndDate(Date.valueOf(endDate));
            membershipRegistration.setStatus("active");
            membershipRegistration.setLessonCount(0);
            membershipRegistration.setNextSession(null);
            membershipRegistration.setLastSession(null);

            BigDecimal price = new BigDecimal(amount);
            BigDecimal fee = price.multiply(new BigDecimal("0.10"))
                                  .setScale(0, RoundingMode.HALF_UP);

            Payment payment = new Payment();
            payment.setUserId(user.getId());
            payment.setUserName(user.getName());
            payment.setMembershipNum(membershipNum);
            payment.setGymId(membership.getGymNum());
            payment.setTrainerId(membership.getTrainerNum());
            payment.setPaymentPrice(price);
            payment.setPaymentFee(fee);
            payment.setMethod("TOSS");
            payment.setStatus("결제완료");
            payment.setOrderId(orderId);

            if ("pt".equals(membership.getType())) {
                payment.setPaymentType("PT");
            } else {
                payment.setPaymentType("MEMBERSHIP");
            }
            
            paymentService.registerMembershipAndPayment(membershipRegistration, payment);

            response.getWriter().write("{\"success\":true, \"message\":\"결제가 완료되었습니다.\"}");
            
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\":false, \"message\":\"결제 처리 중 오류가 발생했습니다.\"}");
		}

	}
	
	private LocalDate calculateEndDate(LocalDate startDate, Membership membership) {
        String type = membership.getType();
        Integer typeRep = membership.getTypeRep();

        if ("day".equals(type)) {
            return startDate;
        }

        if ("month".equals(type)) {
            return startDate.plusMonths(typeRep);
        }

        if ("pt".equals(type)) {
            return startDate.plusMonths(3);
        }

        return startDate;
    }
}

