package controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.SalesService;
import service.admin.SalesServiceImpl;

/**
 * Servlet implementation class Sales
 */
@WebServlet("/admin/sales")
public class Sales extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SalesService salesService = new SalesServiceImpl();
       
    public Sales() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 인코딩 설정 (필터에서 처리 안 할 경우 대비)
	    request.setCharacterEncoding("UTF-8");

	 // 헬퍼 메소드: null, 빈문자열, "undefined" 문자열 체크
	    String startDate = getSafeParam(request, "startDate", LocalDate.now().minusMonths(1).toString());
	    String endDate = getSafeParam(request, "endDate", LocalDate.now().toString());
	    
	    String queryEndDate = LocalDate.parse(endDate).plusDays(1).toString();
	    
	    String viewType = getSafeParam(request, "viewType", "all");
	    String status = getSafeParam(request, "status", "전체");
	    
	    // 검색어 및 페이지 처리
	    String salesSearch = getSafeParam(request, "salesSearch", "");
	    String paymentSearch = getSafeParam(request, "paymentSearch", "");
	    if(paymentSearch == null || paymentSearch.equals("undefined")) paymentSearch = "";
	    int salesPage = Integer.parseInt(getSafeParam(request, "salesPage", "1"));
	    int paymentPage = Integer.parseInt(getSafeParam(request, "paymentPage", "1"));
	    int pageSize = 10;

	    // 파라미터 맵 구성
	    Map<String, Object> params = new HashMap<>();
	    params.put("startDate", startDate);
	    params.put("endDate", queryEndDate);
	    params.put("viewType", viewType);
	    params.put("salesSearch", salesSearch.trim());
	    params.put("salesOffset", (salesPage - 1) * pageSize);
	    params.put("status", status);
	    params.put("paymentSearch", paymentSearch.trim());
	    params.put("paymentOffset", (paymentPage - 1) * pageSize);
	    params.put("pageSize", pageSize);

	    try {
	        Map<String, Object> dashboardData = salesService.getDashboardData(params);
	        
	        request.setAttribute("data", dashboardData);
	        request.setAttribute("startDate", startDate);
	        request.setAttribute("endDate", endDate);
	        request.setAttribute("currentViewType", viewType);
	        request.setAttribute("currentStatus", status);
	        request.setAttribute("salesSearch", salesSearch);
	        request.setAttribute("paymentSearch", paymentSearch);

	        request.getRequestDispatcher("/admin/sales.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	// 파라미터 검증용 프라이빗 메소드
	private String getSafeParam(HttpServletRequest request, String name, String defaultValue) {
	    String val = request.getParameter(name);
	    if (val == null || val.trim().isEmpty() || val.equals("undefined") || val.equals("null")) {
	        return defaultValue;
	    }
	    return val;
	}
}