package controller.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.ExerciseService;
import service.admin.ExerciseServiceImpl;

/**
 * Servlet implementation class ExGuideList
 */
@WebServlet("/admin/exGuideList")
public class ExGuideList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ExerciseService exerciseService = new ExerciseServiceImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExGuideList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 파라미터 수집
	        String pageStr = request.getParameter("page");
	        int page = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
	        String targetMuscle = request.getParameter("targetMuscle");
	        String searchKeyword = request.getParameter("searchKeyword");

	        // 서비스 호출 (수정된 메서드)
	        Map<String, Object> result = exerciseService.getExerciseGuideList(page, targetMuscle, searchKeyword);

	        // 결과 전달
	        request.setAttribute("guideList", result.get("guideList"));
	        request.setAttribute("pageInfo", result.get("pageInfo"));
	        request.setAttribute("totalCount", result.get("totalCount"));
	        
	        // 3. 목록 화면으로 이동
	        request.getRequestDispatcher("/admin/exGuideList.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath() + "/common/error.jsp");
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
