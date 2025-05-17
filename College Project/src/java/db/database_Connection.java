/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author jay
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class database_Connection {

    public static final String URL = "jdbc:mysql://localhost:3306/myProject";
    public static final String USER = "root";
    public static final String PASSWORD = "root1234";

    static {
        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL Driver", e);
        }
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
        }
        return connection;
    }

    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Failed to close connection: " + e.getMessage());
            }
        }
    }
}
 

