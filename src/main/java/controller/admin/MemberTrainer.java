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
 * Servlet implementation class MemberTrainer
 */
@WebServlet("/admin/memberTrainer")
public class MemberTrainer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberTrainer() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String trainerName = request.getParameter("trainerName");
		String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
		
		if(trainerName != null) {
			if(trainerName.trim().isEmpty()) {
				trainerName = null;
			}
			
			Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("pageInfo", new PageInfo(1));
            paramMap.put("trainerName", trainerName);
            paramMap.put("sortColumn", sortColumn);
            paramMap.put("sortOrder", sortOrder);
			
			try {
				MemberService service = new MemberServiceImpl();
				List<MemberDTO> list = service.trainerList(paramMap);
				
				response.setContentType("application/json;charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				StringBuilder json = new StringBuilder();
				json.append("[");
				for (int i = 0; i < list.size(); i++) {
	                MemberDTO m = list.get(i);
	                json.append("{");
	                json.append("\"trainerName\":\"" + m.getTrainerName() + "\",");
	                json.append("\"trainerTel\":\"" + m.getTrainerTel() + "\",");
	                json.append("\"regDate\":\"" + m.getRegDate() + "\",");
	                json.append("\"trainerClientCount\":" + m.getTrainerClientCount() + ",");
	                json.append("\"trainerCal\":" + m.getTrainerCal());
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
		int reqPage = (page != null) ? Integer.parseInt(page) : 1;
		
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("pageInfo", new PageInfo(reqPage));
        paramMap.put("trainerName", null);
        paramMap.put("sortColumn", null);
        paramMap.put("sortOrder", null);
		
		try {
			MemberService service = new MemberServiceImpl();
			List<MemberDTO> trainerList = service.trainerList(paramMap);
			
			int totalCount = service.totalCnt();
			int gymCount = service.gymCnt();
			int trainerCount = service.trainerCnt();
			int clientCount = service.clientCnt();
			request.setAttribute("pageInfo", paramMap.get("pageInfo"));
			request.setAttribute("trainerList", trainerList);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("gymCount", gymCount);
			request.setAttribute("trainerCount", trainerCount);
			request.setAttribute("clientCount", clientCount);
			request.getRequestDispatcher("/admin/memberTrainer.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "게시글 목록 조회에 오류가 발생했습니다.");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}