package controller.trainer;

import dao.trainer.ClientDAOImpl;
import dto.trainer.ClientDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import dto.common.TrainerDTO;
import service.trainer.ClientService;
import service.trainer.ClientServiceImpl;

@WebServlet({"/trainer/clients", "/clients", "/clients.html"})
public class Clients extends HttpServlet {

    private static final int DEFAULT_PAGE_SIZE = 5;
    private final ClientService clientService = new ClientServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        int trainerId = trainer.getTrainerId();

        int currentPage = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException ignored) {
                    currentPage = 1;
                }
            }

            String filter = request.getParameter("filter");
            if (filter == null || filter.isEmpty()) filter = "all";

            String search = request.getParameter("search");
            if (search == null) search = "";

            int totalClients = clientService.getClientCount(filter, search, trainerId);
            int totalPages = (int) Math.ceil((double) totalClients / DEFAULT_PAGE_SIZE);

            if (currentPage < 1) currentPage = 1;
            if (totalPages > 0 && currentPage > totalPages) currentPage = totalPages;

            int offset = (currentPage - 1) * DEFAULT_PAGE_SIZE;

            List<ClientDTO> clients =
                    clientService.getClients(offset, DEFAULT_PAGE_SIZE, filter, search, trainerId);

            request.setAttribute("clients", clients);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentFilter", filter);
            request.setAttribute("currentSearch", search);

            request.getRequestDispatcher("/trainer/clients.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("err", "클라이언트 목록을 불러오는 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
