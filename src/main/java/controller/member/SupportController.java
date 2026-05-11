package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.InquiryDTO;
import dto.member.UserDTO;
import service.member.SupportService;
import service.member.SupportServiceImpl;

@WebServlet("/member/support")
public class SupportController extends HttpServlet {

    private SupportService service = new SupportServiceImpl();

    // ── GET: 문의 목록 + 페이지 진입 ────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        List<InquiryDTO> list = service.getList(loginUser.getEmail());
        request.setAttribute("list", list);
        request.getRequestDispatcher("/member/support.jsp").forward(request, response);
    }

    // ── POST: 문의 등록 ──────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.setStatus(401);
            return;
        }

        // support.jsp form name="type" → INQUIRY.category ENUM 매핑
        // form 값: "결제","계정","오류","기타" (선택값)
        String typeParam = request.getParameter("type");
        String category  = mapToCategory(typeParam);

        InquiryDTO dto = new InquiryDTO();
        dto.setUserEmail(loginUser.getEmail()); // Mapper에서 서브쿼리로 user_id 변환
        dto.setCategory(category);
        dto.setTitle(request.getParameter("title"));
        dto.setContent(request.getParameter("content"));
        dto.setFile(null); // 파일 업로드 추후 추가

        service.write(dto);

        response.sendRedirect("support");
    }

    /**
     * support.jsp select 값 → INQUIRY.category ENUM('계정','결제','오류','제휴','기타') 매핑
     */
    private String mapToCategory(String type) {
        if (type == null) return "기타";
        switch (type) {
            case "결제":    return "결제";
            case "계정":    return "계정";
            case "오류":    return "오류";
            case "제휴":    return "제휴";
            case "신고":    return "기타";  // 신고는 기타로 처리
            default:        return "기타";
        }
    }
}
