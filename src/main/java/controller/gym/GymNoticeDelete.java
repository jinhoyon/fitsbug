package controller.gym;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.gym.GymNotice;
import dto.gym.NoticeImages;
import dto.member.UserDTO;
import service.gym.GymNoticeService;
import service.gym.GymNoticeServiceImpl;

/**
 * Servlet implementation class GymNoticeDelete
 */
@WebServlet("/gym/noticeDelete")
public class GymNoticeDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GymNoticeDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GymNoticeService service = new GymNoticeServiceImpl();
		
		try {
			String noticeIdStr = request.getParameter("noticeId");

			if (noticeIdStr == null || noticeIdStr.trim().isEmpty()) {
			    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			    return;
			}

			int noticeId = Integer.parseInt(noticeIdStr);
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = user.getOtherId();


            GymNotice notice = service.getNoticeDetail(noticeId);

            if (notice == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            if (notice.getGymId() != gymId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

         // 1. 이미지 목록 조회
            List<NoticeImages> imageList = service.getImagesByNoticeId(noticeId);
            
            // 2. 실제 이미지 파일 삭제
            String uploadPath = request.getServletContext().getRealPath("/noticeDetailImages");

            if (imageList != null) {
                for (NoticeImages image : imageList) {
                    String imageUrl = image.getImageUrl();

                    if (imageUrl != null) {
                        String fileName = new File(imageUrl).getName();
                        File file = new File(uploadPath, fileName);

                        if (file.exists()) {
                            file.delete();
                        }
                    }
                }
            }

            service.deleteNotice(noticeId);

            response.sendRedirect(request.getContextPath() + "/gym/notice");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
	

}
