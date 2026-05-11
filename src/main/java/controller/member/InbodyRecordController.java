package controller.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dto.member.InbodyLogDTO;
import dto.member.UserDTO;
import service.member.InbodyLogService;
import service.member.InbodyLogServiceImpl;

@WebServlet("/member/inbody")
public class InbodyRecordController extends HttpServlet {

    private InbodyLogService service = new InbodyLogServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");

        UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");
        if (user == null) { response.setStatus(401); return; }

        List<InbodyLogDTO> list = service.getListByEmail(user.getEmail());
        if (list == null) list = new ArrayList<>();

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            InbodyLogDTO d = list.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                .append("\"date\":\"").append(nvl(d.getRecordDate())).append("\",")
                .append("\"weight\":").append(d.getWeight()).append(",")
                .append("\"muscle\":").append(d.getMuscleMass()).append(",")
                .append("\"fat\":").append(d.getBodyFat())
                .append("}");
        }
        json.append("]");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        UserDTO user = (UserDTO) request.getSession().getAttribute("loginUser");
        if (user == null) {
            response.getWriter().write("{\"success\":false,\"msg\":\"notLogin\"}");
            return;
        }

        int memberId = user.getOtherId();

        String weightStr = request.getParameter("weight");
        String muscleStr = request.getParameter("muscle");
        String fatStr    = request.getParameter("fat");

        if (weightStr == null || weightStr.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"msg\":\"체중을 입력해주세요\"}");
            return;
        }

        InbodyLogDTO dto = new InbodyLogDTO();
        dto.setMemberId(memberId);
        dto.setRecordDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        dto.setWeight(parseDoubleOrZero(weightStr));
        dto.setMuscleMass(parseDoubleOrZero(muscleStr));   // DB: muscle_mass
        dto.setBodyFat(parseDoubleOrZero(fatStr));          // DB: body_fat
        dto.setImg(request.getParameter("img"));

        int result = service.save(dto);

        if (result > 0) {
            response.getWriter().write("{\"success\":true}");
        } else {
            response.getWriter().write("{\"success\":false}");
        }
    }

    private String nvl(String s) { return s == null ? "" : s; }
    private double parseDoubleOrZero(String s) {
        try { return s != null ? Double.parseDouble(s.trim()) : 0; } catch (Exception e) { return 0; }
    }
}
