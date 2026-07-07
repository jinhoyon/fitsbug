package util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

/**
 * Database connection settings loaded from {@code config.properties}.
 * Falls back to local dev defaults matching the original mybatis-config.xml values.
 */
public final class DatabaseConfig {

    private static final String DEFAULT_DRIVER = "org.mariadb.jdbc.Driver";
    private static final String DEFAULT_URL = "jdbc:mariadb://localhost:3306/fitsbug";
    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "7564";

    private static final String driver;
    private static final String url;
    private static final String username;
    private static final String password;

    static {
        Properties props = loadProperties();
        driver = props.getProperty("db.driver", DEFAULT_DRIVER).trim();
        url = props.getProperty("db.url", DEFAULT_URL).trim();
        username = props.getProperty("db.username", DEFAULT_USERNAME).trim();
        password = props.getProperty("db.password", DEFAULT_PASSWORD).trim();
    }

    private DatabaseConfig() {}

    public static Properties getMybatisProperties() {
        Properties props = new Properties();
        props.setProperty("db.driver", driver);
        props.setProperty("db.url", url);
        props.setProperty("db.username", username);
        props.setProperty("db.password", password);
        return props;
    }

    private static Properties loadProperties() {
        Properties props = new Properties();
        try (InputStream in = DatabaseConfig.class.getClassLoader().getResourceAsStream("config.properties")) {
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
