package controller.member;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import dto.trainer.AvailabilityDTO;
import service.member.MemberService;
import service.member.MemberServiceImpl;
import service.member.TrainerService;
import service.member.TrainerServiceImpl;

@WebServlet("/member/main")
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/member/login");
            return;
        }

        MemberService service = new MemberServiceImpl();
        Map<String, Object> memberInfo = service.findByEmail(loginUser.getEmail());
        System.out.println(memberInfo);

        request.setAttribute("memberInfo", memberInfo);
        // 세션에도 저장 (다른 JSP에서도 접근 가능)
        session.setAttribute("memberInfo", memberInfo);

        // 트레이너 일정 로드
        if (memberInfo != null && memberInfo.get("trainer_id") != null) {
            Integer trainerId = (Integer) memberInfo.get("trainer_id");

            TrainerService trainerService = new TrainerServiceImpl();

            // 가용 일정 목록
            List<AvailabilityDTO> availList = trainerService.getTrainerAvailabilityList(trainerId);
            request.setAttribute("availList", availList);

            // JS용 JSON 문자열 생성 (availabilityJson)
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < availList.size(); i++) {
                AvailabilityDTO a = availList.get(i);
                if (i > 0) json.append(",");
                json.append("{")
                    .append("\"dayOfWeek\":\"").append(a.getDayOfWeek()).append("\",")
                    .append("\"startTime\":\"").append(a.getStartTime()).append("\",")
                    .append("\"endTime\":\"").append(a.getEndTime()).append("\"")
                    .append("}");
            }
            json.append("]");
            request.setAttribute("availabilityJson", json.toString());

            // 트레이너 이름
            Map<String, Object> trainer = trainerService.getTrainerInfoByTrainerId(trainerId);
            if (trainer != null) {
                request.setAttribute("scheduleTrainerName", trainer.get("name"));
            }
        }

        request.getRequestDispatcher("/member/main.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
