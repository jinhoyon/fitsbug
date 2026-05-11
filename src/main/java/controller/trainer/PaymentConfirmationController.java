package controller.trainer;

import dto.trainer.ClientDTO;
import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.JSONObject;
import util.MybatisSqlSessionFactory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@WebServlet("/payment/confirm")
public class PaymentConfirmationController extends HttpServlet {

    private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
    private static final String TOSS_CONFIRM_URL = "https://api.tosspayments.com/v1/payments/confirm";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Read JSON body from client
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;

        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject requestBody = new JSONObject(sb.toString());

        String paymentKey = requestBody.getString("paymentKey");
        String orderId = requestBody.getString("orderId");
        int amount = requestBody.getInt("amount");

        // 2. Encode secret key (Basic Auth)
        String encodedKey = Base64.getEncoder()
                .encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        // 3. Create Toss API request
        URL url = new URL(TOSS_CONFIRM_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Basic " + encodedKey);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        // 4. Request body to Toss
        JSONObject tossRequest = new JSONObject();
        tossRequest.put("paymentKey", paymentKey);
        tossRequest.put("orderId", orderId);
        tossRequest.put("amount", amount);

        OutputStream os = conn.getOutputStream();
        os.write(tossRequest.toString().getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        int statusCode = conn.getResponseCode();

        InputStream is = (statusCode == 200)
                ? conn.getInputStream()
                : conn.getErrorStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));

        StringBuilder responseBody = new StringBuilder();
        String responseLine;

        while ((responseLine = br.readLine()) != null) {
            responseBody.append(responseLine.trim());
        }

        br.close();

        // 5. Return response to frontend
        response.setStatus(statusCode);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(responseBody.toString());

        // 6. (Optional but IMPORTANT) Business logic
        if (statusCode == 200) {
            JSONObject tossResponse = new JSONObject(responseBody.toString());

            // Toss 응답에서 필드 추출
            PaymentDTO dto = new PaymentDTO();
            dto.setPaymentKey(tossResponse.getString("paymentKey"));
            dto.setOrderId(tossResponse.getString("orderId"));
            dto.setAmount(tossResponse.getInt("totalAmount"));
            dto.setStatus(tossResponse.getString("status"));       // "DONE"
            dto.setMethod(tossResponse.getString("method"));       // "카드"
            dto.setApprovedAt(tossResponse.getString("approvedAt")); // "2024-01-01T00:00:00+09:00"

            // 세션에서 로그인한 회원 번호 가져오기
//            HttpSession session = request.getSession(false);
//            if (session != null && session.getAttribute("loginMember") != null) {
//                ClientDTO client = (ClientDTO) session.getAttribute("loginMember");
//                dto.setClientId(client.getClientId());
//            }

            // MyBatis로 DB 저장
            try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
                sqlSession.insert("payment.insertPayment", dto);
                sqlSession.commit();
            } catch (Exception e) {
                e.printStackTrace();
                // 결제는 됐는데 DB 저장 실패 → 로그 필수, 운영에선 알림 처리
                System.out.println("❌ DB 저장 실패: " + e.getMessage());
            }

            System.out.println("✅ Payment Success & Saved: " + orderId);
        }
    }
}