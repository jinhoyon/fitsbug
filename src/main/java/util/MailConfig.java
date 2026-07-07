package util;

import java.util.Properties;

/**
 * Gmail SMTP settings from {@code config.properties}.
 */
public final class MailConfig {

    private static final String DEFAULT_HOST = "smtp.gmail.com";
    private static final String DEFAULT_PORT = "587";

    private static final String smtpHost;
    private static final String smtpPort;
    private static final String username;
    private static final String appPassword;

    static {
        Properties props = ConfigLoader.load();
        smtpHost = props.getProperty("mail.smtp.host", DEFAULT_HOST).trim();
        smtpPort = props.getProperty("mail.smtp.port", DEFAULT_PORT).trim();
        username = props.getProperty("mail.username", "").trim();
        appPassword = props.getProperty("mail.app.password", "").trim();
    }

    private MailConfig() {}

    public static String getSmtpHost() {
        return smtpHost;
    }

    public static String getSmtpPort() {
        return smtpPort;
    }

    public static String getUsername() {
        return username;
    }

    public static String getAppPassword() {
        return appPassword;
    }

    public static boolean isConfigured() {
        return !username.isEmpty() && !appPassword.isEmpty();
    }
}
