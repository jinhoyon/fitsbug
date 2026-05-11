package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.ReportDTO;
import dto.member.UserDTO;
import service.member.ReportService;
import service.member.ReportServiceImpl;

@WebServlet("/member/report")
public class ReportController extends HttpServlet {

    private ReportService service = new ReportServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        ReportDTO dto = new ReportDTO();
        dto.setPostId(Integer.parseInt(request.getParameter("postId")));
        dto.setReason(request.getParameter("reason"));
        dto.setDetail(request.getParameter("detail"));
        dto.setTargetId(Integer.parseInt(request.getParameter("targetId")));
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
        dto.setId(loginUser.getId());
        dto.setReporterId(loginUser.getId());
        
        System.out.println(dto);
        service.insertReport(dto);

        response.sendRedirect(request.getContextPath() + "/member/community");
    }
}