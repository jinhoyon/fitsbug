package controller.trainer;

import dto.common.UserDTO;
import service.trainer.TrainerMessageService;
import service.trainer.TrainerMessageServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/trainer/messages")
public class Messages extends HttpServlet {

    private final TrainerMessageService messageService = new TrainerMessageServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int myId = loginUser.getId();

        try {
            TrainerMessageService.MessagesPageData pageData =
                    messageService.loadPage(myId, request.getParameter("roomId"));

            request.setAttribute("rooms", pageData.rooms);
            request.setAttribute("messages", pageData.messages);
            request.setAttribute("currentRoomId", pageData.currentRoomId);
            request.setAttribute("partnerNickname", pageData.partnerNickname);
            request.setAttribute("partnerProfileImg", pageData.partnerProfileImg);
            request.setAttribute("partnerId", pageData.partnerId);
            request.setAttribute("unreadCount", pageData.unreadCount);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/trainer/messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int myId = loginUser.getId();

        String partnerIdStr = request.getParameter("partnerId");
        String messageText = request.getParameter("message");
        String roomIdStr = request.getParameter("roomId");

        if (partnerIdStr == null || messageText == null || messageText.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/trainer/messages"
                    + (roomIdStr != null ? "?roomId=" + roomIdStr : ""));
            return;
        }

        try {
            int partnerId = Integer.parseInt(partnerIdStr);
            int roomId = messageService.sendMessage(myId, partnerId, messageText);
            response.sendRedirect(request.getContextPath() + "/trainer/messages?roomId=" + roomId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/trainer/messages"
                    + (roomIdStr != null ? "?roomId=" + roomIdStr : ""));
        }
    }
}
