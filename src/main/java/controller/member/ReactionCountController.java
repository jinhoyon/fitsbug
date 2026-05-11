package controller.member;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.member.UserDTO;
import service.member.PostReactionService;
import service.member.PostReactionServiceImpl;

//hasReacted()  → 로그인 유저가 눌렀는지 여부 추가
@WebServlet("/member/reactionCount")
public class ReactionCountController extends HttpServlet {

    private PostReactionService service = new PostReactionServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json;charset=UTF-8");

        int postId = Integer.parseInt(request.getParameter("postId"));

        List<Map<String, Object>> counts = service.getAllCounts(postId);

        // 타입별 카운트 맵으로 정리
        long likeCnt = 0, goodCnt = 0, muscleCnt = 0;
        if (counts != null) {
            for (Map<String, Object> row : counts) {
                String t   = (String) row.get("type");
                long   cnt = ((Number) row.get("cnt")).longValue();
                if ("like".equals(t))        likeCnt   = cnt;
                else if ("good".equals(t))   goodCnt   = cnt;
                else if ("muscle".equals(t)) muscleCnt = cnt;
            }
        }

        // 로그인 유저가 눌렀는지 확인
        HttpSession session   = request.getSession(false);
        UserDTO     loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;
        String userId = (loginUser != null) ? loginUser.getEmail() : null;

        boolean likeReacted   = false;
        boolean goodReacted   = false;
        boolean muscleReacted = false;

        if (userId != null) {
            likeReacted   = service.hasReacted(postId, userId, "like")   > 0;
            goodReacted   = service.hasReacted(postId, userId, "good")   > 0;
            muscleReacted = service.hasReacted(postId, userId, "muscle") > 0;
        }

        // JSON 직접 조립 (외부 라이브러리 없이)
        String json = String.format(
            "{\"like\":{\"count\":%d,\"reacted\":%b}," +
             "\"good\":{\"count\":%d,\"reacted\":%b}," +
             "\"muscle\":{\"count\":%d,\"reacted\":%b}}",
            likeCnt, likeReacted,
            goodCnt, goodReacted,
            muscleCnt, muscleReacted
        );

        response.getWriter().write(json);
    }
}
