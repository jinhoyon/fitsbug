package util;

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
        Properties props = ConfigLoader.load();
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
}
