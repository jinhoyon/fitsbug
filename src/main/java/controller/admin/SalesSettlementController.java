package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.SalesService;
import service.admin.SalesServiceImpl;

/**
 * Servlet implementation class SalesSettlement
 */
@WebServlet("/admin/salesSettlement")
public class SalesSettlementController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SalesService salesService = new SalesServiceImpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesSettlementController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		// 1. AJAX 상세 내역 조회 요청인지 확인
        if ("getSettlementDetail".equals(action)) {
            handleGetSettlementDetail(request, response);
            return;
        }
        
		// 1. 파라미터 수집 (날짜, 검색어, 상태 탭 등)
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String searchKeyword = request.getParameter("searchKeyword");
        String status = request.getParameter("status"); // '정산대기' or '정산완료'
        
        // 초기 접속 시 기본값 설정 (예: 최근 1개월)
        if (startDate == null || startDate.isEmpty()) {
            startDate = LocalDate.now().minusMonths(1).toString();
        }
        if (endDate == null || endDate.isEmpty()) {
            endDate = LocalDate.now().toString();
        }
        if (status == null) status = "정산대기"; // 기본 탭 설정
        
        String offsetParam = request.getParameter("offset");
        int offset = (offsetParam != null && !offsetParam.isEmpty()) ? Integer.parseInt(offsetParam) : 0;
        // 2. 파라미터 맵 구성 (매퍼로 전달될 데이터)
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("searchKeyword", searchKeyword);
        params.put("status", status);
        params.put("limit", 10);  
        params.put("offset", offset); // JSP에서 넘긴 offset 반영
        params.put("pageSize", 10);
        params.put("salesPage", 1);   // 필요 시 request에서 받아오도록 확장 가능
        params.put("paymentPage", 1); 
        params.put("salesOffset", 0);    // selectSalesList용 (추가)

        // (선택사항) viewType이나 salesSearch 등 매퍼에 정의된 다른 필터가 있다면 기본값 추가
        params.put("viewType", request.getParameter("viewType")); 
        params.put("salesSearch", request.getParameter("salesSearch"));

        // 3. 서비스 호출하여 통합 데이터 수신
        // (Service 내에 getDashboardData와 같은 통합 메서드를 만드는 것을 추천합니다)
        try {
            // [핵심] 여기서 예외가 발생할 수 있으므로 try 블록 안에 넣습니다.
            Map<String, Object> dashboardData = salesService.getDashboardData(params);
            
            // 데이터가 성공적으로 로드된 경우
            request.setAttribute("data", dashboardData);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);
            request.setAttribute("status", status);
            
            request.getRequestDispatcher("/admin/salesSettlement.jsp").forward(request, response);
        } catch (Exception e) {
            // 2. 에러 발생 시 처리
            e.printStackTrace(); // 개발 중 확인을 위해 콘솔에 에러 출력
            
            // 사용자에게 보여줄 에러 메시지 저장
            request.setAttribute("errorMessage", "데이터를 불러오는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
             
            // 에러 발생 시에도 빈 데이터를 보내거나, 에러 전용 페이지로 보낼 수 있습니다.
            // 여기서는 기존 페이지로 보내되 메시지만 띄우는 방식을 선택합니다.
            request.getRequestDispatcher("/admin/salesSettlement.jsp").forward(request, response);
        }
	}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 정산 처리 요청 (AJAX 또는 Form)
				String action = request.getParameter("action");
			    
			    if ("completeSettlement".equals(action)) {
			        String idParam = request.getParameter("id");
			        
			        // 1. 파라미터 유효성 검사 (세심한 체크)
			        if (idParam == null || idParam.isEmpty()) {
			            response.getWriter().write("fail: invalid id");
			            return;
			        }

			        try {
			            int settlementId = Integer.parseInt(idParam);
			            
			            // 2. 서비스 호출 및 예외 처리
			            // 이 메서드가 Exception을 던지므로 try-catch가 필수입니다.
			            boolean success = salesService.processSettlement(settlementId);
			            if (success) {
			                response.getWriter().write("success");
			            } else {
			                response.getWriter().write("fail");
			            }
			            
			        } catch (NumberFormatException e) {
			            e.printStackTrace();
			            response.getWriter().write("fail: format error");
			        } catch (Exception e) {
			            // 3. DB 오류 등 예상치 못한 예외 발생 시
			            e.printStackTrace();
			            // 클라이언트(AJAX 등)에게 에러 상황임을 알림
			            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
			            response.getWriter().write("error: " + e.getMessage());
			        }
			    } else {
			        // 다른 action이 들어왔을 경우 기존 doGet 로직으로 유도하거나 처리
			        doGet(request, response);
			    }

			}

	
	private void handleGetSettlementDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int settlementId = Integer.parseInt(idParam);
            // Service에서 상세 내역 리스트를 가져온다고 가정
            // List<Map<String, Object>> 형식이 구현되어 있어야 함
            List<Map<String, Object>> details = salesService.getSettlementDetail(settlementId);
            
            // JSON 수동 조립
            StringBuilder json = new StringBuilder();
            json.append("{");
            // 1. 은행 및 예금주 정보 (첫 번째 행에서 추출)
            if (!details.isEmpty()) {
                Map<String, Object> first = details.get(0);
                json.append("\"bankName\": \"").append(first.get("bankName")).append("\",");
                json.append("\"accountNum\": \"").append(first.get("accountNum")).append("\",");
                json.append("\"ownerName\": \"").append(first.get("ownerName")).append("\",");
            }
            
            json.append("\"details\": [");
            for (int i = 0; i < details.size(); i++) {
                Map<String, Object> m = details.get(i);
                json.append("{");
                json.append("\"memberName\": \"").append(m.get("memberName")).append("\",");
                json.append("\"payDate\": \"").append(m.get("payDate")).append("\",");
                json.append("\"payAmount\": ").append(m.get("payAmount")).append(",");
                json.append("\"fee\": ").append(m.get("fee")).append(",");
                json.append("\"netAmount\": ").append(m.get("netAmount"));
                json.append("}");
                if (i < details.size() - 1) json.append(",");
            }
            json.append("]");
            json.append("}");

            out.print(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"detail load fail\"}");
        }
    }
}
