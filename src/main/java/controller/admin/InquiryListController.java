package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.InquiryDTO;
import service.admin.InquiryService;
import service.admin.InquiryServiceImpl;
import service.admin.ReportService;
import service.admin.ReportServiceImpl;

/**
 * Servlet implementation class InquiryList
 */
@WebServlet("/admin/inquiryList")
public class InquiryListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InquiryService inquiryService = new InquiryServiceImpl();
	private ReportService reportService = new ReportServiceImpl();
    
    public InquiryListController() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String action = request.getParameter("action");
        
			try {
	            if ("detail".equals(action)) {
	                // [AJAX] 문의 내역 단건 상세 조회
	                int id = Integer.parseInt(request.getParameter("id"));
	                InquiryDTO detail = inquiryService.getInquiryDetail(id);

	                // GSON 없이 직접 JSON 문자열 생성
	                String json = convertInquiryToJson(detail);

	                response.setContentType("application/json;charset=UTF-8");
	                response.getWriter().print(json);

	            } else {
	                // [일반] 리스트 페이지 로딩
	                String status = request.getParameter("status") != null ? request.getParameter("status") : "WAIT";
	                String keyword = request.getParameter("keyword");

	                List<InquiryDTO> list = inquiryService.getInquiryList(status, keyword);
	                int totalCount = inquiryService.totalCnt();
	                int inquiryCount = inquiryService.inquiryCnt();
	                int reportCount = reportService.reportCnt();
	                request.setAttribute("inquiryList", list);
	                request.setAttribute("currentStatus", status); 
	                request.setAttribute("totalCount", totalCount);
	                request.setAttribute("inquiryCount", inquiryCount);
	                request.setAttribute("reportCount", reportCount);
	                request.getRequestDispatcher("/admin/inquiry.jsp").forward(request, response);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(500, "문의 내역 조회 중 시스템 오류 발생");
	        }
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // [AJAX] 문의 답변(처리) 실행
	        try {
	            String inquiryIdStr = request.getParameter("inquiryId");
	            if(inquiryIdStr == null) {
	                 response.getWriter().print("{\"success\": false, \"message\": \"inquiryId is missing\"}");
	                 return;
	            }

	            int id = Integer.parseInt(inquiryIdStr);
	            String resultText = request.getParameter("result");

	            // 서비스 레이어의 규격에 맞춰 DTO 포장
	            InquiryDTO inquiry = new InquiryDTO();
	            inquiry.setInquiryId(id);
	            inquiry.setResult(resultText);
	            // 답변 완료 시 상태를 COMPLETE로 명시 (서비스나 매퍼에서 처리해도 되지만 DTO에 담아 전달)
	            inquiry.setStatus("COMPLETE"); 

	            boolean success = inquiryService.answerInquiry(inquiry);

	            response.setContentType("application/json;charset=UTF-8");
	            response.getWriter().print("{\"success\": " + success + "}");

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().print("{\"success\": false, \"message\": \"Server Error\"}");
	        }
	    }

	    // GSON 없이 InquiryDTO를 JSON 문자열로 만드는 수동 변환기
	    private String convertInquiryToJson(InquiryDTO dto) {
	        if (dto == null) return "{}";

	        // 1. 날짜 데이터 안전 변환
	        String regDate = (dto.getRegDate() != null) ? dto.getRegDate().toString() : "";
	        String processDate = (dto.getProcessDate() != null) ? dto.getProcessDate().toString() : "";

	        // 2. 문자열 이스케이프 및 개행 제거 (JSON 문법 오류 방지)
	        String title = dto.getTitle() != null ? dto.getTitle().replace("\"", "\\\"").replace("\n", " ") : "";
	        String content = dto.getContent() != null ? dto.getContent().replace("\"", "\\\"").replace("\n", " ") : "";
	        String result = dto.getResult() != null ? dto.getResult().replace("\"", "\\\"").replace("\n", " ") : "";
	        String file = dto.getFile() != null ? dto.getFile().replace("\"", "\\\"") : "";
	        String userName = dto.getUserName() != null ? dto.getUserName() : "알 수 없음";
	        
	        // 3. String.format을 이용한 JSON 조립 (InquiryDTO 칼럼 기준)
	        return String.format(
	        		"{\"inquiryId\": %d, \"userId\": %d, \"userName\": \"%s\", \"category\": \"%s\", \"title\": \"%s\", \"content\": \"%s\", \"file\": \"%s\", \"result\": \"%s\", \"status\": \"%s\", \"regDate\": \"%s\", \"processDate\": \"%s\"}",
	            dto.getInquiryId(),
	            dto.getUserId(),
	            userName,
	            dto.getCategory() != null ? dto.getCategory() : "",
	            title,
	            content,
	            file,
	            result,
	            dto.getStatus() != null ? dto.getStatus() : "",
	            regDate,
	            processDate
	        );
	    }
}