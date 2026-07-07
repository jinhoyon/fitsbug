package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.Review;
import dto.common.UserDTO;
import service.gym.GymReviewService;
import service.gym.GymReviewServiceImpl;

@WebServlet("/gym/reviewUpdate")
public class ReviewUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReviewUpdateController() {
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
        	
			int gymId = Integer.parseInt(request.getParameter("gymId"));

            int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
            int star = Integer.parseInt(request.getParameter("star"));
            String comment = request.getParameter("comment");

            GymReviewService service = new GymReviewServiceImpl();
            
            Review origin = service.getReview(reviewNum);

            if (origin == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            Review review = new Review();
            review.setReviewNum(reviewNum);
            review.setClientId(user.getId());
            review.setRating((double)star);
            review.setComment(comment);

            service.updateReview(review, user.getId());

            response.sendRedirect(request.getContextPath() + "/member/gymDetail?gymId=" + gymId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("리뷰 수정 중 오류", e);
        }
    }
}