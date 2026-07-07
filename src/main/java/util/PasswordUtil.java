package util;

import at.favre.lib.crypto.bcrypt.BCrypt;

/**
 * BCrypt hashing with plaintext fallback for legacy passwords.
 * On successful plaintext verification, callers should re-hash and persist.
 */
public final class PasswordUtil {

    private PasswordUtil() {}

    public static String hash(String plainPassword) {
        if (plainPassword == null) {
            throw new IllegalArgumentException("password must not be null");
        }
        return BCrypt.withDefaults().hashToString(12, plainPassword.toCharArray());
    }

    public static boolean verify(String plainPassword, String storedPassword) {
        if (plainPassword == null || storedPassword == null) {
            return false;
        }
        if (isBcryptHash(storedPassword)) {
            return BCrypt.verifyer().verify(plainPassword.toCharArray(), storedPassword).verified;
        }
        return plainPassword.equals(storedPassword);
    }

    public static boolean isBcryptHash(String storedPassword) {
        return storedPassword != null
                && (storedPassword.startsWith("$2a$")
                || storedPassword.startsWith("$2b$")
                || storedPassword.startsWith("$2y$"));
    }
}
