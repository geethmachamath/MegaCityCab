<%@ page import="com.login.model.Employee" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Employee driver = (Employee) session.getAttribute("employee");
    if (driver == null || !"driver".equals(driver.getType())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int driverId = driver.getId();
    int bookingId = 0;
    String action = "";
    
    try {
        bookingId = Integer.parseInt(request.getParameter("id"));
        action = request.getParameter("action");
    } catch (NumberFormatException e) {
        response.sendRedirect("viewOrders.jsp?error=invalidid");
        return;
    }
    
    if (!"complete".equals(action)) {
        response.sendRedirect("viewOrders.jsp?error=invalidaction");
        return;
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    boolean success = false;
    String message = "";
    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/login_system";
        String dbUser = "root";
        String dbPassword = "1234";
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        
        // Verify this booking belongs to driver's cab and is confirmed
        String checkSql = "SELECT b.id FROM bookings b " +
                         "INNER JOIN cabs c ON b.cab_id = c.id " +
                         "WHERE b.id = ? AND c.driver_id = ? AND b.status = 'confirmed'";
        
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setInt(1, bookingId);
        pstmt.setInt(2, driverId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            rs.close();
            pstmt.close();
            
            String updateSql = "UPDATE bookings SET status = 'completed' WHERE id = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, bookingId);
            
            int affected = pstmt.executeUpdate();
            if (affected > 0) {
                success = true;
                message = "Booking marked as completed successfully";
            } else {
                message = "Failed to update booking status";
            }
        } else {
            message = "Access denied: Booking not found or not in confirmed status";
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            // Ignore
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Booking Status</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h2 { color: #333; }
        .success { color: green; background: #f0fff0; padding: 10px; border: 1px solid green; margin: 20px 0; border-radius: 4px; }
        .error { color: red; background: #fff0f0; padding: 10px; border: 1px solid red; margin: 20px 0; border-radius: 4px; }
        .button { margin-top: 20px; padding: 8px 15px; text-decoration: none; background: #f2f2f2; color: #333; border-radius: 4px; display: inline-block; border: 1px solid #ddd; }
        .button:hover { background: #e7e7e7; }
    </style>
    <meta http-equiv="refresh" content="3;url=viewOrders.jsp">
</head>
<body>
    <h2>Update Booking Status</h2>
    
    <div class="<%= success ? "success" : "error" %>">
        <%= message %>
    </div>
    
    <p>Redirecting in 3 seconds...</p>
    <a href="viewOrders.jsp" class="button">Return Now</a>
</body>
</html>