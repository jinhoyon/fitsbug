package util;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

/** Loads {@code config.properties} from classpath or working directory. */
public final class ConfigLoader {

    private ConfigLoader() {}

    public static Properties load() {
        Properties props = new Properties();
        try (InputStream in = ConfigLoader.class.getClassLoader().getResourceAsStream("config.properties")) {
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
