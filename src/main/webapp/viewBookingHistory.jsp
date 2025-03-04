<%@ page import="java.sql.*, com.login.util.DBConnection, com.login.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking History</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .no-bookings {
            margin-top: 20px;
            padding: 10px;
            background-color: #f8f8f8;
            border-left: 4px solid #ccc;
        }
        .status-confirmed {
            color: green;
            font-weight: bold;
        }
        .status-pending {
            color: orange;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>Your Booking History</h2>
    
    <%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean hasBookings = false;
    
    try {
        con = DBConnection.getConnection();
        
        // Using user's email from the session to get their bookings
        String query = "SELECT b.*, c.model AS cab_model FROM bookings b " +
                       "JOIN cabs c ON b.cab_id = c.id " +
                       "WHERE b.email = ? " +
                       "ORDER BY b.id DESC";
        
        pstmt = con.prepareStatement(query);
        pstmt.setString(1, user.getEmail());
        rs = pstmt.executeQuery();
        
        // Check if there are any bookings
        if (rs.next()) {
            hasBookings = true;
    %>
    
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Cab Model</th>
            <th>From</th>
            <th>To</th>
            <th>Distance (km)</th>
            <th>Status</th>
            <th>Amount</th>
        </tr>
        
        <%
            // Display the first row (we already moved to it with rs.next())
            do {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("cab_model") %></td>
                <td><%= rs.getString("pickup") %></td>
                <td><%= rs.getString("dropLocation") %></td>
                <td><%= rs.getInt("kms") %></td>
                <td class="<%= rs.getString("status").equals("confirmed") ? "status-confirmed" : "status-pending" %>">
                    <%= rs.getString("status") %>
                </td>
                <td>
                    <% if (rs.getObject("totalAmount") != null) { %>
                        ₹ <%= String.format("%.2f", rs.getDouble("totalAmount")) %>
                    <% } else { %>
                        Pending
                    <% } %>
                </td>
            </tr>
        <%
            } while (rs.next());
        %>
    </table>
    
    <%
        } else {
            // No bookings found
            hasBookings = false;
        }
        
        if (!hasBookings) {
    %>
        <div class="no-bookings">
            <p>You haven't made any bookings yet.</p>
            <p>Click <a href="bookVehicle.jsp">here</a> to book a vehicle now.</p>
        </div>
    <%
        }
    } catch (Exception e) {
        out.println("<p style='color:red'>Error retrieving booking history: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    %>
    
    <p><a href="userDashboard.jsp">Back to Dashboard</a></p>
</body>
</html>