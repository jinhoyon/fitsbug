package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.AdminMainDTO;
import service.admin.AdminMainService;
import service.admin.AdminMainServiceImpl;

/**
 * Servlet implementation class AdminMain
 */
@WebServlet("/admin/main")
public class AdminMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminMainService adminMainService = new AdminMainServiceImpl();

    public AdminMain() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			AdminMainDTO stats = adminMainService.getDashboardStats();
	        request.setAttribute("stats", stats); // JSP에서는 ${stats.필드명}으로 접근
            
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 처리 (예: 에러 페이지 이동 등)
        }
		
		request.getRequestDispatcher("/admin/adminMain.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
