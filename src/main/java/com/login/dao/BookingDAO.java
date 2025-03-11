package com.login.dao;

import com.login.model.Booking;
import com.login.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    public List<Booking> getBookingsForDriver(String driverEmail) throws SQLException, ClassNotFoundException {
        System.out.println("BookingDAO: getBookingsForDriver called with driverEmail: " + driverEmail);
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
            System.out.println("BookingDAO: Executing query: " + stmt.toString());
            
            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("BookingDAO: Fetching results...");
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
                System.out.println("BookingDAO: Retrieved " + bookings.size() + " bookings");
            }
        } catch (SQLException e) {
            System.out.println("BookingDAO: SQLException in getBookingsForDriver: " + e.getMessage());
            throw e;
        } catch (ClassNotFoundException e) {
            System.out.println("BookingDAO: ClassNotFoundException in getBookingsForDriver: " + e.getMessage());
            throw e;
        }
        return bookings;
    }

    public boolean updateBookingStatus(int bookingId, String driverEmail, String status) throws SQLException, ClassNotFoundException {
        System.out.println("BookingDAO: updateBookingStatus called with bookingId: " + bookingId + ", driverEmail: " + driverEmail + ", status: " + status);

        // Verify that the booking belongs to the driver
        String verifyQuery = "SELECT COUNT(*) " +
                            "FROM bookings b " +
                            "JOIN cabs c ON b.cab_id = c.id " +
                            "JOIN employees e ON c.driver_id = e.id " +
                            "WHERE b.id = ? AND LOWER(e.email) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement verifyStmt = conn.prepareStatement(verifyQuery)) {
            verifyStmt.setInt(1, bookingId);
            verifyStmt.setString(2, driverEmail.toLowerCase());
            
            System.out.println("BookingDAO: Executing verify query: " + verifyStmt.toString());
            try (ResultSet rs = verifyStmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("BookingDAO: Verification result - matching bookings: " + count);
                    if (count == 0) {
                        System.out.println("BookingDAO: Booking does not belong to this driver or does not exist");
                        return false;
                    }
                } else {
                    System.out.println("BookingDAO: Verification query returned no results");
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("BookingDAO: SQLException in updateBookingStatus (verify): " + e.getMessage());
            throw e;
        }

        // Update the status
        String updateQuery = "UPDATE bookings SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
            updateStmt.setString(1, status);
            updateStmt.setInt(2, bookingId);
            
            System.out.println("BookingDAO: Executing update query: " + updateStmt.toString());
            int rowsAffected = updateStmt.executeUpdate();
            System.out.println("BookingDAO: Rows affected by update: " + rowsAffected);
            if (rowsAffected > 0) {
                System.out.println("BookingDAO: Successfully updated status for booking ID: " + bookingId);
            } else {
                System.out.println("BookingDAO: No rows updated for booking ID: " + bookingId);
            }
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("BookingDAO: SQLException in updateBookingStatus (update): " + e.getMessage());
            throw e;
        }
    }
}