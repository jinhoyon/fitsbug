package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.member.UserDTO;
import service.gym.GymPaymentService;
import service.gym.GymPaymentServiceImpl;

@WebServlet("/gym/refundApprove")
public class GymRefundApprove extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymRefundApprove() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
        	
        	HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");

			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/member/login");
				return;
			}

			Integer gymId = user.getOtherId();
			
			String paymentNumStr = request.getParameter("paymentNum");

	        if (paymentNumStr == null || paymentNumStr.trim().isEmpty()) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("invalid_payment");
	            return;
	        }
			
            int paymentNum = Integer.parseInt(paymentNumStr);

            GymPaymentService service = new GymPaymentServiceImpl();
            service.approveRefund(paymentNum, gymId);

            String ajax = request.getHeader("X-Requested-With");

            if ("XMLHttpRequest".equals(ajax)) {
                response.setContentType("text/plain; charset=UTF-8");
                response.getWriter().write("success");
            } else {
                response.sendRedirect(request.getContextPath() + "/gym/memberManage");
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("invalid_payment");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("fail");
        }
    }
}