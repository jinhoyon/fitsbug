package service.member;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import dao.member.UserDAO;
import dao.member.UserDAOImpl;
import dto.member.UserDTO;

// ✅ LoginDTO/LoginDAO → UserDTO/UserDAO 로 전면 수정
public class KakaoServiceImpl implements KakaoService {

    // ✅ LoginDAO → UserDAO
    private UserDAO dao = new UserDAOImpl();

    @Override
    public String getAccessToken(String code) {
        String accessToken = "";

        try {
            URL url = new URL("https://kauth.kakao.com/oauth/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String params = "grant_type=authorization_code"
                    + "&client_id=REST_API_KEY"
                    + "&redirect_uri=http://localhost:8080/kakaoLogin"
                    + "&code=" + code;

            OutputStream os = conn.getOutputStream();
            os.write(params.getBytes());
            os.flush();

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));

            StringBuilder result = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            JSONObject json = new JSONObject(result.toString());
            accessToken = json.getString("access_token");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return accessToken;
    }

    @Override
    public UserDTO getUserInfo(String token) {
        UserDTO member = null;

        try {
            URL url = new URL("https://kapi.kakao.com/v2/user/me");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + token);

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));

            StringBuilder result = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            JSONObject json    = new JSONObject(result.toString());
            JSONObject account = json.getJSONObject("kakao_account");
            String email       = account.getString("email");

            // ✅ UserDAO.findByEmail 사용
            member = dao.findByEmail(email);

            if (member == null) {
                // ✅ LoginDTO → UserDTO, insertKakaoUser → insertSocial
                member = new UserDTO();
                member.setEmail(email);
                member.setNickname("카카오회원_" + System.currentTimeMillis() % 10000);
                member.setRole("MEMBER");
                member.setProvider("kakao");
                member.setEmailVerified(true);

                dao.insertSocial(member);
                member = dao.findByEmail(email);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return member;
    }
}
