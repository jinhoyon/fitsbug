package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.admin.MemberDTO;
import service.admin.MemberService;
import service.admin.MemberServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class Member
 */
@WebServlet("/admin/memberGym")
public class MemberGym extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberGym() {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String gymName = request.getParameter("gymName"); //jsp의 비동기에서 보낸 값 수령
		String sortColumn = request.getParameter("sortColumn");
		String sortOrder = request.getParameter("sortOrder");
		
		if(gymName != null) {
			if(gymName.trim().isEmpty()) {
				gymName = null;
			}
			
			//가져온 값들을 Map에 담기
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("pageInfo", new PageInfo(1));
			paramMap.put("gymName", gymName);
			paramMap.put("sortColumn", sortColumn);
			paramMap.put("sortOrder", sortOrder);

			try {
				MemberService service = new MemberServiceImpl();
				List<MemberDTO> list = service.gymList(paramMap);
				
				response.setContentType("application/json;charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				StringBuilder json = new StringBuilder();
				json.append("[");
				for (int i = 0; i < list.size(); i++) {
	                MemberDTO m = list.get(i);
	                json.append("{");
	                json.append("\"gymName\":\"" + m.getGymName() + "\",");
	                json.append("\"gymTel\":\"" + m.getGymTel() + "\",");
	                json.append("\"regDate\":\"" + m.getRegDate() + "\",");
	                json.append("\"gymClientCount\":" + m.getGymClientCount() + ",");
	                json.append("\"gymCal\":" + m.getGymCal());
	                json.append("}");
	                if (i < list.size() - 1) json.append(",");
	            }
	            json.append("]");

	            out.print(json.toString());
	            out.flush();
	            return; // 비동기 응답 후 종료
	        } catch (Exception e) {
	            e.printStackTrace();
			}
		}
			
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("page");
		int reqPage = (page!=null)? Integer.parseInt(page) : 1;
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("pageInfo", new PageInfo(reqPage));
		paramMap.put("gymName", null);
		paramMap.put("sortColumn", null);
		paramMap.put("sortOrder", null);
		
		try {
			MemberService service = new MemberServiceImpl();
			List<MemberDTO> gymList = service.gymList(paramMap);
			int totalCount = service.totalCnt();
			int gymCount = service.gymCnt();
			int trainerCount = service.trainerCnt();
			int clientCount = service.clientCnt();
			request.setAttribute("pageInfo", paramMap.get("pageInfo"));
			request.setAttribute("gymList", gymList); //여기의 gymList와 JSP의 gymList 이름이 같아야함.
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("gymCount", gymCount);
			request.setAttribute("trainerCount", trainerCount);
			request.setAttribute("clientCount", clientCount);
			request.getRequestDispatcher("/admin/memberGym.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "게시글 목록 조회에 오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
		
	}
}