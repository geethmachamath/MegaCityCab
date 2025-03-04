package com.login.dao;

import com.login.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VehicleDAO {
    
    public int getCabIdByDriverId(int driverId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int cabId = -1;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT id FROM vehicle WHERE driver_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, driverId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                cabId = rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return cabId;
    }
}