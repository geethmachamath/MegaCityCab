<%@ page import="com.login.model.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Employee admin = (Employee) session.getAttribute("employee");
    if (admin == null || !"admin".equals(admin.getType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h2>Welcome, Admin</h2>
    <ul>
        <li><a href="driverDetails.jsp">Driver Details</a></li>
        <li><a href="passengerDetails.jsp">Passenger Details</a></li>
        <li><a href="bookingManagement.jsp">Booking Management</a></li>
        <li><a href="reportGeneration.jsp">Generate Reports</a></li>
        <li><a href="logout">Logout</a></li>
    </ul>
</body>
</html>
