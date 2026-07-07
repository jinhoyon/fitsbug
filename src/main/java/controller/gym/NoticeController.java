package controller.gym;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.GymNotice;
import dto.common.UserDTO;
import service.gym.GymNoticeService;
import service.gym.GymNoticeServiceImpl;

@WebServlet("/gym/notice")
public class NoticeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NoticeController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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


            String sort = request.getParameter("sort");
            if (sort == null || sort.isEmpty()) {
                sort = "latest";
            }

            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            int pageSize = 5;
            int offset = (page - 1) * pageSize;

            Map<String, Object> param = new HashMap<>();
            param.put("gymId", gymId);
            param.put("sort", sort);
            param.put("size", pageSize);
            param.put("start", offset);

            GymNoticeService service = new GymNoticeServiceImpl();

            int totalCount = service.getNoticeCount(gymId);
            List<GymNotice> noticeList = service.getNoticeList(param);

            int totalPage = (int) Math.ceil((double) totalCount / pageSize);
            if (totalPage == 0) {
                totalPage = 1;
            }

            int blockSize = 5;
            int startPage = ((page - 1) / blockSize) * blockSize + 1;
            int endPage = startPage + blockSize - 1;
            if (endPage > totalPage) {
                endPage = totalPage;
            }

            request.setAttribute("noticeList", noticeList);
            request.setAttribute("noticeCount", totalCount);
            request.setAttribute("sort", sort);
            request.setAttribute("page", page);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            request.getRequestDispatcher("/gym/gym_notice.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("공지사항 목록 조회 중 오류", e);
        }
    }
}