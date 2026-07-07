package util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

/**
 * Single source for Toss Payments API keys.
 * Loads {@code config.properties} when present; falls back to Fitsbug test keys.
 */
public final class TossPaymentsConfig {

    private static final String DEFAULT_SECRET_KEY = "test_sk_Ba5PzR0ArnB5zP0Dd4jGrvmYnNeD";
    private static final String DEFAULT_CLIENT_KEY = "test_ck_5OWRapdA8dJO4LMYoZWYVo1zEqZK";

    private static final String secretKey;
    private static final String clientKey;

    static {
        Properties props = loadProperties();
        secretKey = props.getProperty("toss.secret.key", DEFAULT_SECRET_KEY).trim();
        clientKey = props.getProperty("toss.client.key", DEFAULT_CLIENT_KEY).trim();
    }

    private TossPaymentsConfig() {}

    public static String getSecretKey() {
        return secretKey;
    }

    public static String getClientKey() {
        return clientKey;
    }

    public static String getBasicAuthorizationHeader() {
        String token = java.util.Base64.getEncoder()
                .encodeToString((secretKey + ":").getBytes(java.nio.charset.StandardCharsets.UTF_8));
        return "Basic " + token;
    }

    private static Properties loadProperties() {
        Properties props = new Properties();
        try (InputStream in = TossPaymentsConfig.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in != null) {
                props.load(in);
                return props;
            }
        } catch (IOException ignored) {
        }

        Path path = Paths.get("config.properties");
        if (Files.isRegularFile(path)) {
            try (InputStream in = Files.newInputStream(path)) {
                props.load(in);
            } catch (IOException ignored) {
            }
        }
        return props;
    }
}
