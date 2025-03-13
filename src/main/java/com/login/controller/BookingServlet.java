package com.login.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.login.util.DBConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Get all parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String pickup = request.getParameter("pickup");
            String dropLocation = request.getParameter("dropLocation");
            int kms = Integer.parseInt(request.getParameter("kms"));
            int cabId = Integer.parseInt(request.getParameter("cab_id"));
            
            System.out.println("Processing booking: " + name + ", " + email + ", cab: " + cabId);
            

            con = DBConnection.getConnection();
            
            // Debug database connection
            if (con == null) {
                System.out.println("Database connection is null");
                response.sendRedirect("bookVehicle.jsp?error=connection");
                return;
            }
            
            // Prepare SQL - adapt field names if needed
            // Using explicit column list to prevent field naming issues
            String query = "INSERT INTO bookings (name, email, phone, pickup, dropLocation, kms, cab_id, status) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')";
            
            pstmt = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, pickup);
            pstmt.setString(5, dropLocation);
            pstmt.setInt(6, kms);
            pstmt.setInt(7, cabId);
            
            // Execute the insert
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            if (rowsAffected > 0) {
                rs = pstmt.getGeneratedKeys();
                int bookingId = 0;
                if (rs.next()) {
                    bookingId = rs.getInt(1);
                    System.out.println("Generated booking ID: " + bookingId);
                }
                
                // Get cab details
                String cabQuery = "SELECT model FROM cabs WHERE id = ?";
                pstmt = con.prepareStatement(cabQuery);
                pstmt.setInt(1, cabId);
                rs = pstmt.executeQuery();
                
                String cabModel = "Standard Cab";
                double ratePerKm = 150.0; // Default value
                
                if (rs.next()) {
                    cabModel = rs.getString("model");
                }
                
                // Calculate amount
                double amount = ratePerKm * kms;
                double tax = amount * 0.08;
                double totalAmount = amount + tax;
                
                // Store in session
                HttpSession session = request.getSession();
                session.setAttribute("bookingId", bookingId);
                session.setAttribute("name", name);
                session.setAttribute("pickup", pickup);
                session.setAttribute("dropLocation", dropLocation);
                session.setAttribute("kms", kms);
                session.setAttribute("cabModel", cabModel);
                session.setAttribute("amount", amount);
                session.setAttribute("tax", tax);
                session.setAttribute("totalAmount", totalAmount);
                
                response.sendRedirect("calculateBill.jsp");
            } else {
                System.out.println("No rows affected by insert");
                response.sendRedirect("bookVehicle.jsp?error=insert");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception in BookingServlet: " + e.getMessage());
            response.sendRedirect("bookVehicle.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}