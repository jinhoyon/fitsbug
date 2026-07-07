package util;

import java.util.Properties;

/**
 * Kakao OAuth settings from {@code config.properties}.
 */
public final class KakaoConfig {

    private static final String DEFAULT_REDIRECT_URI = "http://localhost:8080/Fitsbug/member/kakaoLogin";

    private static final String clientId;
    private static final String redirectUri;

    static {
        Properties props = ConfigLoader.load();
        clientId = props.getProperty("kakao.client.id", "").trim();
        redirectUri = props.getProperty("kakao.redirect.uri", DEFAULT_REDIRECT_URI).trim();
    }

    private KakaoConfig() {}

    public static String getClientId() {
        return clientId;
    }

    public static String getRedirectUri() {
        return redirectUri;
    }
}
