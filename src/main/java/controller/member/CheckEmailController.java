package controller.member;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.member.UserDAO;
import dao.member.UserDAOImpl;

@WebServlet("/member/checkEmail")
public class CheckEmailController extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		    throws IOException {
		
				req.setCharacterEncoding("UTF-8");

		        String email = req.getParameter("email");
		        
		        if(email == null || email.isEmpty()){
		            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
		            return;
		        }

		        UserDAO dao = new UserDAOImpl();
		        boolean exists = dao.isEmailExists(email);

		        resp.setContentType("application/json; charset=UTF-8");

		        String json = "{\"exists\":" + exists + "}";

		        resp.getWriter().write(json);
		}
	}