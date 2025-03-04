package com.login.dao;

import com.login.model.User;
import com.login.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    // Register user
    public boolean registerUser(User user) {
        try (Connection con = DBConnection.getConnection()) {
            String query = "INSERT INTO users (name, address, nic, email, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getAddress());
            ps.setString(3, user.getNic());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Validate user login
    public User validateUser(String email, String password) {
        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("nic"),
                    rs.getString("email"),
                    rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // **NEW**: Update user details
    public boolean updateUser(User user) {
        try (Connection con = DBConnection.getConnection()) {
            String query = "UPDATE users SET name=?, address=?, nic=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getAddress());
            ps.setString(3, user.getNic());
            ps.setString(4, user.getEmail());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
