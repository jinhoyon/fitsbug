package util;

public final class SortOrderUtil {

    private SortOrderUtil() {}

    public static String sanitize(String sortOrder) {
        if ("DESC".equalsIgnoreCase(sortOrder)) {
            return "DESC";
        }
        return "ASC";
    }
}
