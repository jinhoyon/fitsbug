package service.common;

import dao.common.TossDAO;
import dao.common.TossDAOImpl;
import dto.common.TossDTO;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import util.MybatisSqlSessionFactory;
import util.TossPaymentsConfig;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class TossPaymentServiceImpl implements TossPaymentService {

    private static final String CONFIRM_URL = "https://api.tosspayments.com/v1/payments/confirm";

    private final TossDAO tossDAO = new TossDAOImpl();

    @Override
    public JSONObject confirmPayment(String paymentKey, String orderId, long amount) throws Exception {
        URL url = new URL(CONFIRM_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", TossPaymentsConfig.getBasicAuthorizationHeader());
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject body = new JSONObject();
        body.put("paymentKey", paymentKey);
        body.put("orderId", orderId);
        body.put("amount", amount);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.toString().getBytes(StandardCharsets.UTF_8));
        }

        int responseCode = conn.getResponseCode();
        InputStream is = (responseCode >= 200 && responseCode < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        String responseText = readStream(is);
        JSONObject result = new JSONObject(responseText);
        if (responseCode != 200) {
            throw new RuntimeException(result.toString());
        }
        return result;
    }

    @Override
    public JSONObject cancelPayment(String paymentKey, String cancelReason) throws Exception {
        URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", TossPaymentsConfig.getBasicAuthorizationHeader());
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject body = new JSONObject();
        body.put("cancelReason", cancelReason);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.toString().getBytes(StandardCharsets.UTF_8));
        }

        int responseCode = conn.getResponseCode();
        InputStream is = (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream();
        String responseText = readStream(is);
        JSONObject result = new JSONObject(responseText);
        if (responseCode != 200) {
            throw new RuntimeException(result.toString());
        }
        return result;
    }

    @Override
    public void saveToss(TossDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            tossDAO.insert(session, dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public TossDTO findByOrderId(String orderId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return tossDAO.findByOrderId(session, orderId);
        } finally {
            session.close();
        }
    }

    @Override
    public void updateStatus(String orderId, String status) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            tossDAO.updateStatus(session, orderId, status);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public String getPaymentKeyByOrderId(String orderId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return tossDAO.findPaymentKeyByOrderId(session, orderId);
        } finally {
            session.close();
        }
    }

    private String readStream(InputStream is) throws Exception {
        if (is == null) {
            return "{}";
        }
        BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line.trim());
        }
        return sb.toString();
    }
}
