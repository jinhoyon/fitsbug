package controller.gym;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.gym.GymNotice;
import service.gym.GymNoticeService;
import service.gym.GymNoticeServiceImpl;

import java.io.File;
import dto.gym.NoticeImages;
import dto.member.UserDTO;

import javax.servlet.annotation.MultipartConfig;

@WebServlet("/gym/noticeWrite")
@MultipartConfig
public class GymNoticeWrite extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GymNoticeWrite() {
        super();
    }

    @Override
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


            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            if (content != null) {
                content = content.replaceAll("<img[^>]*src=[\"']data:image/[^>]*>", "");
                content = content.replaceAll("<p>\\s*</p>", "");
                content = content.trim();
            }

            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()) {
                request.setAttribute("msg", "제목과 내용을 입력해주세요.");
                request.setAttribute("url", request.getContextPath() + "/gym/notice");
                request.getRequestDispatcher("/common/alert.jsp").forward(request, response);
                return;
            }

            GymNotice notice = new GymNotice();
            notice.setGymId(gymId);
            notice.setTitle(title.trim());
            notice.setContent(content.trim());

            GymNoticeService service = new GymNoticeServiceImpl();
            service.writeNotice(notice);
            
            String uploadPath = request.getServletContext().getRealPath("/uploads");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            int orderIndex = 0;

            for (Part part : request.getParts()) {
                if ("noticeImages".equals(part.getName()) && part.getSize() > 0) {

                    String originalFileName = new File(part.getSubmittedFileName()).getName();

                    if (originalFileName == null || originalFileName.trim().isEmpty()) {
                        continue;
                    }

                    String contentType = part.getContentType();
                    if (contentType == null || !contentType.startsWith("image/")) {
                        continue;
                    }

                    String ext = "";
                    int dotIndex = originalFileName.lastIndexOf(".");
                    if (dotIndex != -1) {
                        ext = originalFileName.substring(dotIndex);
                    }

                    String fileName =
                            System.currentTimeMillis() + "_"
                            + java.util.UUID.randomUUID().toString().replace("-", "")
                            + ext;

                    part.write(uploadPath + File.separator + fileName);

                    NoticeImages image = new NoticeImages();
                    image.setNoticeId(notice.getId());
                    image.setImageUrl(fileName);
                    image.setOrderIndex(orderIndex++);

                    service.addImage(image);
                }
            }

            response.sendRedirect(request.getContextPath() + "/gym/notice");

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("msg", "공지사항 등록 중 오류가 발생했습니다.");
            request.setAttribute("url", request.getContextPath() + "/gym/notice");
            request.getRequestDispatcher("/common/alert.jsp").forward(request, response);
        }
    }
}