package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

public class KakaoUtil {
    private static final String CLIENT_ID = "8f4eb9739b20ebd5580366d6839c08af";
    private static final String REDIRECT_URI = "http://localhost:8080/kakaoLogin";

    public static String getAccessToken(String code) {
        String accessToken = "";

        try {
            URL url = new URL("https://kauth.kakao.com/oauth/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String params =
                    "grant_type=authorization_code" +
                    "&client_id=" + CLIENT_ID +
                    "&redirect_uri=" + REDIRECT_URI +
                    "&code=" + code;

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            writer.write(params);
            writer.flush();

            int responseCode = conn.getResponseCode();

            BufferedReader br;

            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            String line;
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            br.close();

            // JSON 파싱
            JSONObject json = new JSONObject(result.toString());
            accessToken = json.getString("access_token");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    public static String getUserEmail(String accessToken) {
        String email = "";

        try {
            URL url = new URL("https://kapi.kakao.com/v2/user/me");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader br;

            int responseCode = conn.getResponseCode();

            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            String line;
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            br.close();

            JSONObject json = new JSONObject(result.toString());

            JSONObject kakaoAccount = json.getJSONObject("kakao_account");

            if (kakaoAccount.has("email")) {
                email = kakaoAccount.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return email;
    }
}