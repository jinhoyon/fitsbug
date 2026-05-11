package controller.member;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import service.member.HotTimeService;
import service.member.HotTimeServiceImpl;

@WebServlet("/member/hotTime")
public class HotTimeController extends HttpServlet {

    private HotTimeService service = new HotTimeServiceImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json;charset=UTF-8");

        HttpSession session = req.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if(loginUser == null){
            resp.getWriter().write("{}");
            return;
        }

        String email = loginUser.getEmail();

        String json = service.getHotTimeData(email);

        resp.getWriter().write(json);
    }
}