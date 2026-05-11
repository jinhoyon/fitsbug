package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public static Connection getConnection() {

        try {
            Class.forName("org.mariadb.jdbc.Driver");

            return DriverManager.getConnection(
                "jdbc:mariadb://localhost:3306/fitsbug",
                "root",
                "7564"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
	}
}