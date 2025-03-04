package com.login.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.login.util.DBConnection;

@WebServlet("/BookingConfirmServlet")
public class BookingConfirmServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = DBConnection.getConnection();
            String query = "UPDATE bookings SET status = 'confirmed', totalAmount = ? WHERE id = ?";
            
            pstmt = con.prepareStatement(query);
            pstmt.setDouble(1, totalAmount);
            pstmt.setInt(2, bookingId);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Successful update
                response.sendRedirect("userDashboard.jsp?bookingSuccess=true");
            } else {
                // Failed update
                response.sendRedirect("calculateBill.jsp?error=true");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("calculateBill.jsp?error=true");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}