package controller.member;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@WebServlet("/member/verifyCode")
public class VerifyCodeController extends HttpServlet {

    // ─────────────────────────────────────────────────
    // GET 방식 (쿼리파라미터: ?code=123456)
    // join.jsp 에서 fetch("verifyCode", { method:"POST", body:JSON }) 로 호출하므로
    // 하위 호환성을 위해 GET도 유지
    // ─────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String inputCode = request.getParameter("code");
        processVerify(inputCode, request, response);
    }

    // ─────────────────────────────────────────────────
    // POST 방식 (JSON body: {"email":"...","code":"123456"})
    // join.jsp 의 verifyCode() 함수가 POST + JSON으로 호출
    // ─────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain; charset=UTF-8");

        String inputCode = null;

        String contentType = request.getContentType();

        if (contentType != null && contentType.contains("application/json")) {
            // ── JSON body 파싱 ──
            StringBuilder sb = new StringBuilder();
            BufferedReader br = request.getReader();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            try {
                JSONObject json = new JSONObject(sb.toString());
                inputCode = json.optString("code", null);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // ── form 파라미터 방식 ──
            inputCode = request.getParameter("code");
        }

        processVerify(inputCode, request, response);
    }

    // ─────────────────────────────────────────────────
    // 공통 인증 처리 로직
    // ─────────────────────────────────────────────────
    private void processVerify(String inputCode,
                                HttpServletRequest request,
                                HttpServletResponse response) throws IOException {

        response.setContentType("text/plain; charset=UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.getWriter().write("fail");
            return;
        }

        String sessionCode = (String) session.getAttribute("authCode");
        Long   authTime    = (Long)   session.getAttribute("authTime");

        // ── 세션에 코드가 없는 경우 ──
        if (sessionCode == null || authTime == null) {
            response.getWriter().write("fail");
            return;
        }

        // ── 3분(180초) 만료 체크 ──
        long now = System.currentTimeMillis();
        if ((now - authTime) > 180_000L) {
            // 만료된 코드는 세션에서 제거
            session.removeAttribute("authCode");
            session.removeAttribute("authTime");
            session.removeAttribute("authEmail");
            response.getWriter().write("expired");
            return;
        }

        // ── 코드 일치 여부 확인 (공백 제거 후 비교) ──
        if (inputCode != null && inputCode.trim().equals(sessionCode.trim())) {
            // ✅ 인증 성공 → 세션에 인증 완료 플래그 저장
            session.setAttribute("emailVerified", true);
            // 사용한 코드는 재사용 방지를 위해 제거
            session.removeAttribute("authCode");
            session.removeAttribute("authTime");
            response.getWriter().write("success");
        } else {
            response.getWriter().write("fail");
        }
    }
}
