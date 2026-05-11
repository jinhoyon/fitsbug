package controller.trainer;

import dto.trainer.AvailabilityDTO;
import dto.trainer.PricingDTO;
import dto.trainer.TrainerDTO;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/trainer/signup/step5")
public class SignupController5 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingTrainerUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/signup");
            return;
        }
        request.getRequestDispatcher("/trainer/signup5.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingTrainerUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/signup");
            return;
        }

        int userId = (int) session.getAttribute("pendingTrainerUserId");

        TrainerService trainerService = new TrainerServiceImpl();
        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);

        try {
            // Build pricing list
            String[] labels       = request.getParameterValues("pricingLabel");
            String[] sessionCounts = request.getParameterValues("sessionCount");
            String[] prices       = request.getParameterValues("price");
            String[] popularRows  = request.getParameterValues("popularRow");

            Set<String> popularSet = new HashSet<>();
            if (popularRows != null) Collections.addAll(popularSet, popularRows);

            List<PricingDTO> pricingList = new ArrayList<>();
            if (labels != null) {
                for (int i = 0; i < labels.length; i++) {
                    if (labels[i] == null || labels[i].trim().isEmpty()) continue;
                    PricingDTO p = new PricingDTO();
                    p.setLabel(labels[i].trim());
                    p.setSessionCount(parseIntSafe(sessionCounts, i, 1));
                    p.setPrice(parseIntSafe(prices, i, 0));
                    p.setPopular(popularSet.contains(String.valueOf(i)));
                    pricingList.add(p);
                }
            }

            // Build availability list
            String[] allDays = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
            List<AvailabilityDTO> availabilityList = new ArrayList<>();
            for (String day : allDays) {
                if (request.getParameter("availEnabled_" + day) != null) {
                    AvailabilityDTO a = new AvailabilityDTO();
                    a.setDayOfWeek(day);
                    String start = request.getParameter("startTime_" + day);
                    String end   = request.getParameter("endTime_" + day);
                    a.setStartTime(start != null && !start.isEmpty() ? start : "09:00");
                    a.setEndTime(end   != null && !end.isEmpty()   ? end   : "18:00");
                    availabilityList.add(a);
                }
            }

            trainerService.savePricingAndAvailability(trainer.getTrainerId(), pricingList, availabilityList);

            session.removeAttribute("pendingTrainerUserId");
            response.sendRedirect(request.getContextPath() + "/trainer/login");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "저장에 실패했습니다. 다시 시도해 주세요.");
            request.getRequestDispatcher("/trainer/signup5.jsp").forward(request, response);
        }
    }

    private int parseIntSafe(String[] arr, int i, int defaultVal) {
        if (arr == null || i >= arr.length || arr[i] == null || arr[i].isEmpty()) return defaultVal;
        try { return Integer.parseInt(arr[i]); } catch (NumberFormatException e) { return defaultVal; }
    }
}
