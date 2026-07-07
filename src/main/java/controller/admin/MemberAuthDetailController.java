package controller.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.MemberService;
import service.admin.MemberServiceImpl;

/**
 * Servlet implementation class MemberAuthDetail
 */
@WebServlet("/admin/memberAuthDetail")
public class MemberAuthDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberAuthDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
        String authType = request.getParameter("authType");
        
        try {
        MemberService service = new MemberServiceImpl();
        Map<String, Object> m = service.getAuthDetail(userId, authType);
        if (m == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"name\":\"").append(m.get("name")).append("\",");
        json.append("\"email\":\"").append(m.get("email")).append("\",");
        json.append("\"tel\":\"").append(m.get("tel")).append("\",");
        json.append("\"address\":\"").append(m.get("address")).append("\",");
        json.append("\"profileImg\":\"").append(m.get("profileImg")).append("\",");
        json.append("\"certFile\":\"").append(m.get("certFile")).append("\",");
        json.append("\"address_detail\":\"").append(m.get("address_detail") != null ? m.get("address_detail") : "").append("\",");
        json.append("\"bizNum\":\"").append(m.get("bizNum")).append("\"");
        json.append("}");
        
        System.out.println(json.toString());

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(json.toString());
        } catch(Exception e) {
        	e.printStackTrace();
        	request.setAttribute("err", "게시글 목록 조회에 오류가 발생했습니다.");
        	request.getRequestDispatcher("error.jsp").forward(request, response);
        }
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
request.setCharacterEncoding("UTF-8");
        
        String userId = request.getParameter("userId");
        String authType = request.getParameter("authType");
        String statusAction = request.getParameter("statusAction"); // "APPROVED"

        boolean isSuccess = false;
        try {
            MemberService service = new MemberServiceImpl();
            // 승인 처리 서비스 호출
            isSuccess = service.approveMember(userId, authType);
            
            if(isSuccess) {
                response.getWriter().print("success");
            } else {
                response.getWriter().print("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("error");
        }
    }
}