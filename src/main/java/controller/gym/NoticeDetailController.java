package controller.gym;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.GymNotice;
import dto.gym.NoticeImages;
import service.gym.GymNoticeService;
import service.gym.GymNoticeServiceImpl;

@WebServlet("/gym/noticeDetail")
public class NoticeDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NoticeDetailController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            String noticeIdStr = request.getParameter("noticeId");

            if (noticeIdStr == null || noticeIdStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            int noticeId = Integer.parseInt(noticeIdStr);

            GymNoticeService service = new GymNoticeServiceImpl();

            GymNotice notice = service.getNoticeDetail(noticeId);

            if (notice == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            service.increaseViewCount(noticeId);
            
            notice = service.getNoticeDetail(noticeId);

            List<NoticeImages> imageList = service.getImagesByNoticeId(noticeId);

            request.setAttribute("notice", notice);
            request.setAttribute("imageList", imageList);

            request.getRequestDispatcher("/gym/gym_noticeDetail.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}