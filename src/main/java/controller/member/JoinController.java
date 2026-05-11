/*
 * package controller;
 * 
 * import java.io.BufferedReader; import java.io.IOException; import
 * javax.servlet.*; import javax.servlet.annotation.WebServlet; import
 * javax.servlet.http.*;
 * 
 * import org.json.simple.JSONObject; import org.json.simple.parser.JSONParser;
 * import org.json.simple.parser.ParseException;
 * 
 * import service.JoinService; import service.JoinServiceImpl;
 * 
 * @WebServlet("/join.do") public class JoinController extends HttpServlet {
 * 
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException {
 * 
 * request.getRequestDispatcher("/join.jsp").forward(request, response); }
 * 
 * protected void doPost(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException {
 * 
 * request.setCharacterEncoding("UTF-8");
 * 
 * String role = request.getParameter("role"); String id =
 * request.getParameter("id"); String pw = request.getParameter("pw");
 * 
 * JoinService service = new JoinServiceImpl(); service.join(id, pw, role);
 * 
 * response.sendRedirect("main.jsp"); } }
 */
package controller.member;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/member/join")
public class JoinController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/member/join.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("password", request.getParameter("password"));
        session.setAttribute("nickname", request.getParameter("nickname"));
        session.setAttribute("name", request.getParameter("name"));
        session.setAttribute("phone", request.getParameter("phone"));
        session.setAttribute("age",    request.getParameter("age"));
        session.setAttribute("gender", request.getParameter("gender"));
        session.setAttribute("role", request.getParameter("role"));

        response.sendRedirect(request.getContextPath() + "/member/step2");
    }
}