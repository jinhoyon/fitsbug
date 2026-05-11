package controller.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.MemberDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

@WebServlet("/member/reserveLesson")
public class ReserveLessonController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login");
            return;
        }

        MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");
        if (memberInfo == null || memberInfo.getTrainerId() == null || memberInfo.getTrainerId() == 0) {
            resp.sendRedirect(req.getContextPath() + "/member/main");
            return;
        }
        if (memberInfo.getLessonCount() <= 0) {
            resp.sendRedirect(req.getContextPath() + "/member/main?reserveError=noLessons");
            return;
        }

        String lessonDate = req.getParameter("lessonDate");
        String startTime  = req.getParameter("startTime");
        String endTime    = req.getParameter("endTime");

        if (lessonDate == null || startTime == null || endTime == null) {
            resp.sendRedirect(req.getContextPath() + "/member/main?reserveError=1");
            return;
        }

        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("trainerId",  memberInfo.getTrainerId());
            params.put("clientId",   memberInfo.getId());      // MEMBER.id (FK)
            params.put("lessonDate", lessonDate);
            params.put("startTime",  startTime);
            params.put("endTime",    endTime);
            params.put("goal",       null);

            sql.insert("lesson.insertLesson", params);
            sql.update("mapper.MemberMapper.decrementLessonCount", memberInfo.getId());
            sql.commit();

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/member/main?reserveError=1");
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/member/main?reserved=1");
    }
}
