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
    
    try {
        bookingId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("viewOrders.jsp?error=invalidid");
        return;
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean bookingFound = false;
    
    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/login_system";
        String dbUser = "root";
        String dbPassword = "1234";
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        
        // Query to get booking details with vehicle info
        String sql = "SELECT b.*, c.model, c.number_plate " +
                     "FROM bookings b " +
                     "INNER JOIN cabs c ON b.cab_id = c.id " +
                     "WHERE b.id = ? AND c.driver_id = ?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, bookingId);
        pstmt.setInt(2, driverId);
        rs = pstmt.executeQuery();
        
        bookingFound = rs.next();
        if (!bookingFound) {
            // Booking not found or not assigned to this driver
            rs.close();
            pstmt.close();
            conn.close();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            padding: 20px;
        }
        
        .error-message {
            color: red;
            background-color: #fff0f0;
            padding: 10px;
            border: 1px solid red;
            margin: 20px 0;
            border-radius: 4px;
        }
        
        .back-button {
            margin-top: 20px;
            padding: 8px 15px;
            text-decoration: none;
            background-color: #f2f2f2;
            color: #333;
            border-radius: 4px;
            display: inline-block;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <h2>Booking Details</h2>
    <div class="error-message">
        <p>Booking not found or you don't have permission to view it.</p>
    </div>
    <a href="viewOrders.jsp" class="back-button">Back to Bookings</a>
</body>
</html>
<%
            return;
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            padding: 20px;
        }
        
        h2 {
            color: #333;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        
        .booking-details {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .detail-group {
            margin-bottom: 15px;
        }
        
        .detail-label {
            font-weight: bold;
            color: #555;
        }
        
        .detail-value {
            margin-left: 10px;
        }
        
        .status-pending, .status-confirmed, .status-completed, .status-cancelled {
            font-weight: bold;
            padding: 3px 6px;
            border-radius: 3px;
        }
        
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-completed {
            background-color: #cce5ff;
            color: #004085;
        }
        
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .back-button {
            margin-top: 20px;
            padding: 8px 15px;
            text-decoration: none;
            background-color: #f2f2f2;
            color: #333;
            border-radius: 4px;
            display: inline-block;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <h2>Booking Details</h2>
    
    <div class="booking-details">
        <div class="detail-group">
            <span class="detail-label">Booking ID:</span>
            <span class="detail-value"><%= rs.getInt("id") %></span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Status:</span>
            <span class="detail-value">
                <span class="status-<%= rs.getString("status").toLowerCase() %>">
                    <%= rs.getString("status") %>
                </span>
            </span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Booked Date:</span>
            <span class="detail-value"><%= rs.getString("booked_date") %></span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Customer:</span>
            <span class="detail-value"><%= rs.getString("name") %></span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Contact:</span>
            <span class="detail-value">
                Phone: <%= rs.getString("phone") %><br>
                Email: <%= rs.getString("email") %>
            </span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Vehicle:</span>
            <span class="detail-value"><%= rs.getString("model") %> (<%= rs.getString("number_plate") %>)</span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Pickup Location:</span>
            <span class="detail-value"><%= rs.getString("pickup") %></span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Destination:</span>
            <span class="detail-value"><%= rs.getString("dropLocation") %></span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Distance:</span>
            <span class="detail-value"><%= rs.getInt("kms") %> km</span>
        </div>
        
        <div class="detail-group">
            <span class="detail-label">Total Amount:</span>
            <span class="detail-value">
                <% 
                String amount = rs.getString("totalAmount");
                if (amount != null && !amount.equals("null")) {
                    out.print(amount);
                } else {
                    out.print("Not set");
                }
                %>
            </span>
        </div>
    </div>
    
    <a href="viewOrders.jsp" class="back-button">Back to Bookings</a>
    
    <%
        // Close database resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    %>
</body>
</html>