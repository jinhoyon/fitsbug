package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.Review;
import dto.common.UserDTO;
import service.gym.GymReviewService;
import service.gym.GymReviewServiceImpl;

@WebServlet("/gym/reviewWrite")
public class GymReviewWrite extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymReviewWrite() {
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
			
			int loginUserId = user.getId();

            int gymId = Integer.parseInt(request.getParameter("gymId"));
            int star = Integer.parseInt(request.getParameter("star"));
            String comment = request.getParameter("comment");

            Review review = new Review();
            review.setGymId(gymId);
            review.setClientId(loginUserId);
            review.setRating((double) star);
            review.setComment(comment);

            GymReviewService service = new GymReviewServiceImpl();
            service.writeReview(review);

            String ajax = request.getParameter("ajax");

            if ("true".equals(ajax)) {
                response.setContentType("text/plain; charset=UTF-8");
                response.getWriter().write("success");
                return;
            }

            response.sendRedirect(request.getContextPath() + "/member/gymDetail?gymId=" + gymId);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("리뷰 작성 중 오류", e);
        }
    }
}