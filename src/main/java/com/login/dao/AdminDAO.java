package com.login.dao;

import com.login.model.Employee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AdminDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login_system";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    public boolean updateAdmin(Employee admin) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "UPDATE employees SET name = ? WHERE email = ? AND type = 'admin'";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, admin.getName());
            stmt.setString(2, admin.getEmail());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}