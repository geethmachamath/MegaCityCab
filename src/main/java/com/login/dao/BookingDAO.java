package com.login.dao;

import com.login.model.Booking;
import com.login.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    public List<Booking> getBookingsForDriver(String driverEmail) throws SQLException, ClassNotFoundException {
        List<Booking> bookings = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT b.id, b.name, b.phone, b.pickup, b.dropLocation, b.kms, b.cab_id, b.status, b.totalAmount, b.booked_date " +
                 "FROM bookings b " +
                 "JOIN cabs c ON b.cab_id = c.id " +
                 "JOIN employees e ON c.driver_id = e.id " +
                 "WHERE LOWER(e.email) = LOWER(?) " +
                 "ORDER BY b.booked_date DESC")) {
            
            stmt.setString(1, driverEmail.toLowerCase());
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setName(rs.getString("name"));
                    booking.setPhone(rs.getString("phone"));
                    booking.setPickup(rs.getString("pickup"));
                    booking.setDropLocation(rs.getString("dropLocation"));
                    booking.setKms(rs.getInt("kms"));
                    booking.setCabId(rs.getInt("cab_id"));
                    booking.setStatus(rs.getString("status"));
                    booking.setTotalAmount(rs.getDouble("totalAmount"));
                    booking.setBookedDate(rs.getTimestamp("booked_date"));
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    public boolean updateBookingStatus(int bookingId, String newStatus) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE bookings SET status = ? WHERE id = ?")) {
            
            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}