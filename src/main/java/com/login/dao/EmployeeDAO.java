package com.login.dao;

import com.login.model.Employee;
import com.login.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EmployeeDAO {
    public Employee validateEmployee(String email, String password) {
        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM employees WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Employee(rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("type"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
