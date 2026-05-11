package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.ExerciseServiceImpl;

/**
 * Servlet implementation class ExGuideDelete
 */
@WebServlet("/admin/exGuideDelete")
public class ExGuideDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExGuideDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String egNumStr = request.getParameter("egNum");
        if (egNumStr != null) {
            try {
                int egNum = Integer.parseInt(egNumStr);
                // 서비스의 삭제 메서드 호출
                new ExerciseServiceImpl().removeExerciseGuide(egNum);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // 삭제 후 리스트로 복귀
        response.sendRedirect(request.getContextPath() + "/admin/exGuideList");
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
