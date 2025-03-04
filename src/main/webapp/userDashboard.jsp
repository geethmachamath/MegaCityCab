<%@ page import="com.login.model.User" %>
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
    <title>User Dashboard</title>
    <style>
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= user.getName() %></h2>
    
    <% if (request.getParameter("bookingSuccess") != null) { %>
        <div class="success-message">
            Your booking has been confirmed successfully!
        </div>
    <% } %>
    
    <ul>
        <li><a href="bookVehicle.jsp">Book a Vehicle</a></li>
        <li><a href="viewBookingHistory.jsp">View Booking History</a></li>
        <li><a href="myDetails.jsp">My Details</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>