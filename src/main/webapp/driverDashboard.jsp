<%@ page import="com.login.model.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
Employee driver = (Employee) session.getAttribute("employee");
if (driver == null || !"driver".equals(driver.getType())) {
    response.sendRedirect("login.jsp");
    return;
}

// Get the context path dynamically
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; }
        ul { list-style-type: none; padding: 0; }
        li { margin: 10px 0; }
        a { text-decoration: none; color: #007bff; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h2>Welcome, <%= driver.getName() %></h2>
    <ul>
        <li><a href="<%= contextPath %>/ViewOrdersServlet">View Orders</a></li>
        <li><a href="<%= contextPath %>/myDetails.jsp">My Details</a></li>
        <li><a href="<%= contextPath %>/LogoutServlet">Logout</a></li>
    </ul>
</body>
</html>