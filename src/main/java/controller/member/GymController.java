package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.GymDTO;
import service.member.GymService;
import service.member.GymServiceImpl;

@WebServlet("/member/gymList")
public class GymController extends HttpServlet {
	private GymService service = new GymServiceImpl();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String keyword = req.getParameter("keyword");
		String category = req.getParameter("category");
		String sort = req.getParameter("sort");

		String latStr = req.getParameter("lat");
		String lngStr = req.getParameter("lng");
		

		
		Double lat = null;
		Double lng = null;

		if (latStr != null && lngStr != null) {
			lat = Double.parseDouble(latStr);
			lng = Double.parseDouble(lngStr);
		}

		if (keyword == null)
			keyword = "";
		if (category == null)
			category = "전체";
		if (sort == null)
			sort = "recommend";
		System.out.println(keyword);
		System.out.println(category);
		System.out.println(sort);
		System.out.println(latStr);
		System.out.println(lngStr);
		List<GymDTO> list = service.getGymList(keyword, category, sort, lat, lng);
		System.out.println(list);
		req.setAttribute("gymList", list);

		RequestDispatcher rd = req.getRequestDispatcher("/member/gymList.jsp");
		rd.forward(req, resp);

	}
}