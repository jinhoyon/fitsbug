package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.member.ExerciseGuideDTO;
import service.member.ExerciseService;
import service.member.ExerciseServiceImpl;

@WebServlet("/member/guide")
public class ExerciseController extends HttpServlet {
    private ExerciseService service = new ExerciseServiceImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String isAjax = req.getParameter("ajax");

        List<ExerciseGuideDTO> list;

        if(keyword != null && !keyword.trim().isEmpty()) {
            list = service.searchExercises(keyword);
        } else {
            list = service.getAllExercises();
        }

        // ⭐ AJAX 요청이면 카드 HTML만 반환
        if("true".equals(isAjax)) {

            req.setAttribute("guideList", list);

            req.getRequestDispatcher("/member/exerciseCardFragment.jsp")
               .forward(req, resp);
            return;
        }

        // ⭐ 일반 페이지
        req.setAttribute("exerciseList", list);
        
        req.getRequestDispatcher("/member/guideList.jsp").forward(req, resp);
    }
}