package service.gym;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;


public class GymTossCancelServiceImpl implements GymTossCancelService {
	private static final String IMP_KEY = "7420835541001558";
    private static final String IMP_SECRET = "2ekpxPaTztF7qU9duO6iyYuXfCJhGpKQoLZO7ymrt0Ih9Xojw3SfeSYqHBo5IVC2pdkoSlIfZCYd3XdU";

    private String getAccessToken() throws Exception {

        URL url = new URL("https://api.iamport.kr/users/getToken");

        HttpURLConnection conn =
                (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String body = "{"
                + "\"imp_key\":\"" + IMP_KEY + "\","
                + "\"imp_secret\":\"" + IMP_SECRET + "\""
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.getBytes("UTF-8"));
        }

        String response = readResponse(conn);

        String key = "\"access_token\":\"";

        int start = response.indexOf(key) + key.length();
        int end = response.indexOf("\"", start);

        return response.substring(start, end);
    }

    @Override
    public boolean cancelPayment(String orderId, String reason) throws Exception {

    	String accessToken = getAccessToken();

        URL url = new URL("https://api.iamport.kr/payments/cancel");

        HttpURLConnection conn =
                (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", accessToken);
        conn.setDoOutput(true);

        String body = "{"
                + "\"merchant_uid\":\"" + orderId + "\","
                + "\"reason\":\"" + reason + "\""
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.getBytes("UTF-8"));
        }

        String response = readResponse(conn);

        System.out.println("PortOne cancel response = " + response);

        return conn.getResponseCode() == 200
                && response.contains("\"code\":0");
    }
	
    private String readResponse(HttpURLConnection conn) throws Exception {

        InputStream is = conn.getResponseCode() >= 400
                ? conn.getErrorStream()
                : conn.getInputStream();

        BufferedReader br =
                new BufferedReader(new InputStreamReader(is, "UTF-8"));

        StringBuilder sb = new StringBuilder();

        String line;

        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        return sb.toString();
    }

}
