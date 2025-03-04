package com.login.dao;

import com.login.model.Order;
import com.login.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    public List<Order> getOrdersByCabId(int cabId) {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT o.*, u.name, u.email FROM orders o " +
                         "JOIN users u ON o.id = u.id " +
                         "WHERE o.cab_id = ? " +
                         "ORDER BY " +
                         "CASE " +
                         "  WHEN o.status = 'pending' THEN 1 " +
                         "  WHEN o.status = 'confirmed' THEN 2 " +
                         "  WHEN o.status = 'completed' THEN 3 " +
                         "END, o.booked_date DESC";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, cabId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerName(rs.getString("name"));
                order.setCustomerEmail(rs.getString("email"));
                order.setCustomerPhone(rs.getString("phone"));
                order.setPickupLocation(rs.getString("pickup"));
                order.setDropLocation(rs.getString("dropLocation"));
                order.setKms(rs.getDouble("kms"));
                order.setCabId(rs.getInt("cab_id"));
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getDouble("totalAmount"));
                order.setBookedDate(rs.getString("booked_date"));
                
                orders.add(order);
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
        
        return orders;
    }
    
    public boolean updateOrderStatus(int orderId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
}