package controller.trainer;

import dao.trainer.PaymentDAO;
import dao.trainer.PaymentDAOImpl;
import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import util.MybatisSqlSessionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@WebServlet("/payment/cancel")
public class PaymentCancelController extends HttpServlet {
    private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    // GET: cancel.jsp 보여주기
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        PaymentDAOImpl dao = new PaymentDAOImpl();
        PaymentDTO payment = dao.getPaymentByOrderId(orderId);
        request.setAttribute("payment", payment);
        request.getRequestDispatcher("/trainer/payment/cancel.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) sb.append(line);

        JSONObject requestBody = new JSONObject(sb.toString());
        String paymentKey = requestBody.getString("paymentKey");
        String cancelReason = requestBody.getString("cancelReason");

        // Toss 취소 API 호출
        String encodedKey = Base64.getEncoder()
                .encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Basic " + encodedKey);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject tossRequest = new JSONObject();
        tossRequest.put("cancelReason", cancelReason);

        OutputStream os = conn.getOutputStream();
        os.write(tossRequest.toString().getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        int statusCode = conn.getResponseCode();
        InputStream is = (statusCode == 200) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
        StringBuilder responseBody = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) responseBody.append(responseLine.trim());
        br.close();

        if (statusCode == 200) {
            SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
            try {
                sqlSession.update("payment.cancelPayment", paymentKey);
                sqlSession.commit();
                System.out.println("✅ 환불 성공: " + paymentKey);
            } catch (Exception e) {
                sqlSession.rollback();
                e.printStackTrace();
            } finally {
                sqlSession.close();
            }
        }

        response.setStatus(statusCode);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(responseBody.toString());
    }
}