package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.MemberService;
import service.admin.MemberServiceImpl;

/**
 * Servlet implementation class MemberAuth
 */
@WebServlet("/admin/memberAuthList")
public class MemberAuthList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberAuthList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			MemberService service = new MemberServiceImpl();
			List<Map<String,Object>> list = service.getPendingAuthList();
			
			// JSON 문자열 직접 조립
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> m = list.get(i);
                json.append("{");
                json.append("\"userId\":\"").append(m.get("userId")).append("\",");
                json.append("\"userName\":\"").append(m.get("userName")).append("\",");
                json.append("\"regDate\":\"").append(m.get("regDate")).append("\",");
                json.append("\"authType\":\"").append(m.get("authType")).append("\"");
                json.append("}");
                if (i < list.size() - 1) json.append(",");
            }
            json.append("]");

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(json.toString());
            //이거 없어도되나  request.getRequestDispatcher("/admin/memberAuth.jsp").forward(request, response); 
        } catch (Exception e) { 
        	e.printStackTrace();
        	request.setAttribute("err", "게시글 목록 조회에 오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
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
