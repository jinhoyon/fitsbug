package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.FeedbackDTO;

@WebServlet("/member/feedback")
public class FeedbackController extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        List<FeedbackDTO> list = new ArrayList<>();

        // 테스트 데이터
        FeedbackDTO f = new FeedbackDTO();
        f.setDate("2026-04-20");
        f.setTrainerName("김태훈 트레이너");
        f.setSummary("하체 운동 자세 교정 필요");
        f.setComment("스쿼트 시 무릎이 안쪽으로 모이는 경향 있음. "
                   + "발 넓이 유지하고 코어 잡기 중요.");
        list.add(f);

        resp.setContentType("application/json;charset=UTF-8");

        String json = "[";

        for(int i=0;i<list.size();i++){
            FeedbackDTO d = list.get(i);

            json += "{";
            json += "\"date\":\""+d.getDate()+"\",";
            json += "\"trainerName\":\""+d.getTrainerName()+"\",";
            json += "\"summary\":\""+d.getSummary()+"\",";
            json += "\"content\":\""+d.getContent()+"\"";
            json += "}";

            if(i != list.size()-1) json += ",";
        }

        json += "]";

        resp.getWriter().write(json);
    }
}