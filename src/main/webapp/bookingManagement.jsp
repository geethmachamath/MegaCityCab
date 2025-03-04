<%@ page import="com.login.model.Employee" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
Employee admin = (Employee) session.getAttribute("employee");
if (admin == null || !"admin".equals(admin.getType())) {
    response.sendRedirect("login.jsp");
    return;
}

// Database connection parameters
String dbURL = "jdbc:mysql://localhost:3306/login_system";
String dbUser = "root";
String dbPassword = "1234";

// Message variables for feedback
String successMessage = "";
String errorMessage = "";

// Process form submission for updating booking status
if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null && request.getParameter("action").equals("update")) {
    int bookingId = Integer.parseInt(request.getParameter("id"));
    String status = request.getParameter("status");
    String totalAmount = request.getParameter("totalAmount");
    
    try {
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        PreparedStatement updateStmt = conn.prepareStatement(
            "UPDATE bookings SET status = ?, totalAmount = ? WHERE id = ?");
        updateStmt.setString(1, status);
        updateStmt.setString(2, totalAmount);
        updateStmt.setInt(3, bookingId);
        
        int rowsAffected = updateStmt.executeUpdate();
        if (rowsAffected > 0) {
            successMessage = "Booking updated successfully!";
        } else {
            errorMessage = "Failed to update booking!";
        }
        
        updateStmt.close();
        conn.close();
    } catch (SQLException e) {
        errorMessage = "Database error: " + e.getMessage();
    } catch (NumberFormatException e) {
        errorMessage = "Invalid input format!";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .form-inline {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .form-inline select, .form-inline input {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-inline button {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-inline button:hover {
            background-color: #45a049;
        }
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        .nav-link {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #007bff;
        }
        .nav-link:hover {
            text-decoration: underline;
        }
        .status-pending {
            background-color: #fff3cd;
        }
        .status-confirmed {
            background-color: #d4edda;
        }
        .status-completed {
            background-color: #d1ecf1;
        }
        .status-cancelled {
            background-color: #f8d7da;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Management</h2>
        <a href="adminDashboard.jsp" class="nav-link">← Back to Dashboard</a>
        
        <% if (!successMessage.isEmpty()) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        
        <% if (!errorMessage.isEmpty()) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>
        
        <h3>All Bookings</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Pickup</th>
                    <th>Drop Location</th>
                    <th>KMs</th>
                    <th>Cab ID</th>
                    <th>Status</th>
                    <th>Total Amount</th>
                    
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM bookings ORDER BY id DESC");
                    
                    while (rs.next()) {
                        String status = rs.getString("status");
                        String statusClass = "";
                        
                        if ("pending".equalsIgnoreCase(status)) {
                            statusClass = "status-pending";
                        } else if ("confirmed".equalsIgnoreCase(status)) {
                            statusClass = "status-confirmed";
                        } else if ("completed".equalsIgnoreCase(status)) {
                            statusClass = "status-completed";
                        } else if ("cancelled".equalsIgnoreCase(status)) {
                            statusClass = "status-cancelled";
                        }
                %>
                <tr class="<%= statusClass %>">
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("pickup") %></td>
                    <td><%= rs.getString("dropLocation") %></td>
                    <td><%= rs.getInt("kms") %></td>
                    <td><%= rs.getInt("cab_id") %></td>
                    <td>
                        <form method="post" action="bookingManagement.jsp" class="form-inline">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <select name="status">
                                <option value="pending" <%= "pending".equalsIgnoreCase(status) ? "selected" : "" %>>Pending</option>
                                <option value="confirmed" <%= "confirmed".equalsIgnoreCase(status) ? "selected" : "" %>>Confirmed</option>
                                <option value="completed" <%= "completed".equalsIgnoreCase(status) ? "selected" : "" %>>Completed</option>
                                <option value="cancelled" <%= "cancelled".equalsIgnoreCase(status) ? "selected" : "" %>>Cancelled</option>
                            </select>
                            <input type="text" name="totalAmount" value="<%= rs.getBigDecimal("totalAmount") %>" placeholder="Amount" size="8">
                            <button type="submit">Update</button>
                        </form>
                    </td>
                    <td><%= rs.getBigDecimal("totalAmount") %></td>
                   
                </tr>
                <% 
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (SQLException e) {
                    out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
                }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>