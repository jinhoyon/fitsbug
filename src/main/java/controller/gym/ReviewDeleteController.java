package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.Review;
import dto.common.UserDTO;
import service.gym.GymReviewService;
import service.gym.GymReviewServiceImpl;

@WebServlet("/gym/reviewDelete")
public class ReviewDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewDeleteController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
        	
        	HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");

			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/member/login");
				return;
			}
			
			int gymId = Integer.parseInt(request.getParameter("gymId"));
            
            String reviewNumStr = request.getParameter("reviewNum");

            if (reviewNumStr == null || reviewNumStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            int reviewNum = Integer.parseInt(reviewNumStr);

            GymReviewService service = new GymReviewServiceImpl();

            Review origin = service.getReview(reviewNum);

            if (origin == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            service.deleteReview(reviewNum, user.getId());

            response.sendRedirect(request.getContextPath() + "/member/gymDetail?gymId=" + gymId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("리뷰 삭제 중 오류", e);
        }
    }
}