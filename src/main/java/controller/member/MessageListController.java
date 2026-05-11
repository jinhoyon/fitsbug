/*
 * package controller;
 * 
 * import java.io.IOException; import java.util.List;
 * 
 * import javax.servlet.annotation.WebServlet; import
 * javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest;
 * import javax.servlet.http.HttpServletResponse; import
 * javax.servlet.http.HttpSession;
 * 
 * import dto.MemberDTO; import dto.MessageRoomDTO; import
 * service.MessageService; import service.MessageServiceImpl;
 * 
 * @WebServlet("/messageList") public class MessageListController extends
 * HttpServlet {
 * 
 * private MessageService service = new MessageServiceImpl();
 * 
 * protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws
 * IOException {
 * 
 * HttpSession session = req.getSession(); MemberDTO user = (MemberDTO)
 * session.getAttribute("loginUser");
 * 
 * List<MessageRoomDTO> list = service.getMessageRoomList(user.getEmail());
 * 
 * resp.setContentType("application/json;charset=UTF-8");
 * 
 * StringBuilder json = new StringBuilder(); json.append("[");
 * 
 * for(int i=0; i<list.size(); i++){ MessageRoomDTO c = list.get(i);
 * 
 * json.append("{");
 * json.append("\"email\":\"").append(c.getEmail()).append("\",");
 * json.append("\"nickname\":\"").append(c.getNickname()).append("\",");
 * json.append("\"lastMessage\":\"").append(c.getLastMessage()).append("\",");
 * json.append("\"unreadCount\":").append(c.getUnreadCount()); json.append("}");
 * 
 * if(i < list.size()-1) json.append(","); }
 * 
 * json.append("]");
 * 
 * resp.getWriter().write(json.toString()); } }
 */
package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import dto.member.MessageRoomDTO;

@WebServlet("/member/messageList")
public class MessageListController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        if(user == null){
            resp.getWriter().write("[]");
            return;
        }

        // 🔥 더미 채팅 데이터
        List<MessageRoomDTO> list = new ArrayList<>();

        MessageRoomDTO c1 = new MessageRoomDTO();
        c1.setEmail("trainer1@test.com");
        c1.setNickname("김태훈");
        c1.setLastMessage("오늘 운동 잘하셨어요!");
        c1.setUnreadCount(2);

        MessageRoomDTO c2 = new MessageRoomDTO();
        c2.setEmail("trainer2@test.com");
        c2.setNickname("이민수");
        c2.setLastMessage("식단 확인 부탁드려요");
        c2.setUnreadCount(0);

        list.add(c1);
        list.add(c2);

        resp.setContentType("application/json;charset=UTF-8");

        StringBuilder json = new StringBuilder();
        json.append("[");

        for(int i=0; i<list.size(); i++){
            MessageRoomDTO c = list.get(i);

            json.append("{");
            json.append("\"email\":\"").append(c.getEmail()).append("\",");
            json.append("\"nickname\":\"").append(c.getNickname()).append("\",");
            json.append("\"lastMessage\":\"").append(c.getLastMessage()).append("\",");
            json.append("\"unreadCount\":").append(c.getUnreadCount());
            json.append("}");

            if(i < list.size()-1) json.append(",");
        }

        json.append("]");

        resp.getWriter().write(json.toString());
    }
}