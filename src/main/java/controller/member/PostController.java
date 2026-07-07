package controller.member;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.member.CompleteDAO;
import dao.member.CompleteDAOImpl;
import dto.member.PostDTO;
import dto.common.UserDTO;
import service.member.PostService;
import service.member.PostServiceImpl;

@WebServlet("/member/post")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class PostController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PostService service = new PostServiceImpl();
    private CompleteDAO completeDAO = new CompleteDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        List<PostDTO> list = service.getPosts();
        request.setAttribute("postList", list);
        System.out.println(list);

        if (loginUser != null) {

            String email = loginUser.getEmail();

            request.setAttribute("weekLog",
                    completeDAO.getWeekLog(email));

            request.setAttribute("streak",
                    completeDAO.getStreak(email));

            request.setAttribute("best",
                    completeDAO.getBestStreak(email));
        }

        request.getRequestDispatcher("/member/community.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        // 로그인 체크
        if (loginUser == null) {

            response.sendRedirect(
                    request.getContextPath() + "/member/login");

            return;
        }

        // USER.nickname 사용
        String nickname = loginUser.getNickname();

        // 오운완 기록용 이메일
        String email = loginUser.getEmail();

        // 카테고리
        String category = request.getParameter("category");

        // DB 저장용 타입
        String postType =
                "owun".equals(category)
                        ? "exerciseComplete"
                        : "free";

        // 게시글 데이터
        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String hashtags = request.getParameter("hashtags");

        // 이미지 저장 경로
        String dbPath = null;

        try {

            Part filePart = request.getPart("image");

            if (filePart != null
                    && filePart.getSize() > 0) {

                String originalName =
                        filePart.getSubmittedFileName();

                if (originalName != null
                        && !originalName.trim().isEmpty()) {

                    // 확장자 추출
                    String ext = "";

                    int dotIndex =
                            originalName.lastIndexOf(".");

                    if (dotIndex != -1) {
                        ext = originalName.substring(dotIndex);
                    }

                    // 파일명 중복 방지
                    String savedName =
                            UUID.randomUUID().toString()
                                    + ext;

                    /*
                     * 실제 저장 폴더
                     * webapp/uploads
                     */
                    String uploadPath =
                            request.getServletContext()
                                   .getRealPath("/uploads");

                    File uploadDir = new File(uploadPath);

                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    // 실제 파일 저장
                    filePart.write(
                            uploadPath
                                    + File.separator
                                    + savedName
                    );

                    /*
                     * DB 저장 경로
                     * 예:
                     * /프로젝트명/uploads/파일명.jpg
                     */
                    dbPath = savedName;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // DTO 생성
        PostDTO dto = new PostDTO();

        /*
         * PostDTO.userId 는 String 타입
         * USER.nickname 저장
         */
        dto.setNickName(nickname);
        dto.setUserId(loginUser.getId());
        dto.setPostType(postType);
        dto.setTitle(title);
        dto.setBody(body);
        dto.setImage(dbPath);
        dto.setHashtags(hashtags);

        // 게시글 저장
        service.writePost(dto, email);

        // 커뮤니티로 이동
        response.sendRedirect(
                request.getContextPath()
                        + "/member/post"
        );
    }
}