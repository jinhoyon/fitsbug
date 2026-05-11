package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.ReportDTO;
import service.admin.InquiryService;
import service.admin.InquiryServiceImpl;
import service.admin.ReportService;
import service.admin.ReportServiceImpl;

/**
 * Servlet implementation class ReportList
 */
@WebServlet("/admin/reportList")
public class ReportList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquiryService inquiryService = new InquiryServiceImpl();
	private ReportService reportService = new ReportServiceImpl();
	
    public ReportList() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

        try {
            if ("detail".equals(action)) {
                // [AJAX] 상세 내역 단건 조회
                int id = Integer.parseInt(request.getParameter("id"));
                ReportDTO detail = reportService.getReportDetail(id);
                
                // 직접 JSON 문자열 생성 (GSON 없이)
                String json = convertReportToJson(detail);
                
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print(json);
                
            } else {
                // [일반] 전체 페이지 로딩 (기본 WAIT 상태 리스트)
                String status = request.getParameter("status") != null ? request.getParameter("status") : "WAIT";
                String keyword = request.getParameter("keyword");

                List<ReportDTO> list = reportService.getReportList(status, keyword);
                int totalCount = inquiryService.totalCnt();
                int inquiryCount = inquiryService.inquiryCnt();
                int reportCount = reportService.reportCnt();
                request.setAttribute("reportList", list);
                request.setAttribute("currentStatus", status); // 탭 활성화 상태 기억용
                request.setAttribute("totalCount", totalCount);
                request.setAttribute("inquiryCount", inquiryCount);
                request.setAttribute("reportCount", reportCount);
                request.getRequestDispatcher("/admin/report.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "관리자 작전 중 오류 발생");
        }
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// [AJAX] 반려/숨김 처리 실행
		try {
	        // JSP params.append('reportId', reportId) 와 이름을 맞춰야 함
	        String reportIdStr = request.getParameter("reportId");
	        if(reportIdStr == null) {
	             response.getWriter().print("{\"success\": false, \"message\": \"reportId is missing\"}");
	             return;
	        }
	        
	        int id = Integer.parseInt(reportIdStr);
	        String status = request.getParameter("status");
	        String resultText = request.getParameter("result");

	        ReportDTO report = new ReportDTO();
	        report.setReportId(id);
	        report.setStatus(status);
	        report.setResult(resultText);

	        boolean success = reportService.processReport(report);
	        
	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().print("{\"success\": " + success + "}");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().print("{\"success\": false, \"message\": \"Server Error\"}");
	    }
    }

    // GSON 없이 DTO를 JSON 문자열로 만드는 수동 변환기
    private String convertReportToJson(ReportDTO dto) {
        if (dto == null) return "{}";
        
        // 주의: 문자열 데이터에 쌍따옴표(")가 포함될 경우 이스케이프 처리가 필요합니다.
        // 1. 날짜 안전하게 문자열로 변환
        String dateStr1 = (dto.getRegDate() != null) ? dto.getRegDate().toString() : "";
        String dateStr2 = (dto.getProcessDate() != null) ? dto.getProcessDate().toString() : "";
        
        // 2. 문자열 데이터 내 특수문자 제거 (JSON 깨짐 방지)
        String title = dto.getTitle() != null ? dto.getTitle().replace("\"", "\\\"").replace("\n", " ") : "";
        String content = dto.getContent() != null ? dto.getContent().replace("\"", "\\\"").replace("\n", " ") : "";
        String result = dto.getResult() != null ? dto.getResult().replace("\"", "\\\"").replace("\n", " ") : "";
        String file = dto.getFile() != null ? dto.getFile().replace("\"", "\\\"") : "";
        
        return String.format(
        		"{\"reportId\": %d, \"reporterId\": %d, \"reporterName\": \"%s\", \"targetId\": %d, \"targetName\": \"%s\", \"postNum\": %d, \"category\": \"%s\", \"title\": \"%s\", \"content\": \"%s\", \"status\": \"%s\", \"result\": \"%s\", \"file\": \"%s\", \"regDate\": \"%s\", \"processDate\": \"%s\"}",
            dto.getReportId(),
            dto.getReporterId(),
            dto.getReporterName(),
            dto.getTargetId(),
            dto.getTargetName(),
            dto.getPostNum(),
            dto.getCategory() != null ? dto.getCategory() : "",
            title,
            content,
            dto.getStatus(),
            result,
            file,
            dateStr1,
            dateStr2
        );
    }
}
