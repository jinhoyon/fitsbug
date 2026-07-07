package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.JSONObject;

public class KakaoUtil {

    private KakaoUtil() {}

    public static String getAccessToken(String code) {
        if (KakaoConfig.getClientId().isEmpty()) {
            System.err.println("[KakaoUtil] kakao.client.id is not configured in config.properties");
            return "";
        }

        try {
            URL url = new URL("https://kauth.kakao.com/oauth/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String params =
                    "grant_type=authorization_code" +
                    "&client_id=" + URLEncoder.encode(KakaoConfig.getClientId(), StandardCharsets.UTF_8.name()) +
                    "&redirect_uri=" + URLEncoder.encode(KakaoConfig.getRedirectUri(), StandardCharsets.UTF_8.name()) +
                    "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8.name());

            try (OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream(), StandardCharsets.UTF_8)) {
                writer.write(params);
                writer.flush();
            }

            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(),
                    StandardCharsets.UTF_8));

            StringBuilder result = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            br.close();

            JSONObject json = new JSONObject(result.toString());
            return json.getString("access_token");

        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static String getUserEmail(String accessToken) {
        if (accessToken == null || accessToken.isEmpty()) {
            return "";
        }

        try {
            URL url = new URL("https://kapi.kakao.com/v2/user/me");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(
                    responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(),
                    StandardCharsets.UTF_8));

            StringBuilder result = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            br.close();

            JSONObject json = new JSONObject(result.toString());
            JSONObject kakaoAccount = json.getJSONObject("kakao_account");

            if (kakaoAccount.has("email")) {
                return kakaoAccount.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "";
    }
}
