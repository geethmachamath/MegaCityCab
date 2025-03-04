package com.login.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/login_system";
    private static final String USER = "root"; // Change to your MySQL username
    private static final String PASSWORD = "1234"; // Change to your MySQL password
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        // Register JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Open a connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}