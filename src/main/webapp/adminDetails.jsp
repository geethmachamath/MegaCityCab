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
    <title>Admin Details</title>
    <style>
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
        }
        .buttons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>My Details</h2>
        
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <p style="color: green;"><%= message %></p>
        <% } %>
        
        <form action="UpdateAdminServlet" method="post">
            <div class="form-group">
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" value="<%= admin.getId() %>" readonly>
            </div>
            
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= admin.getName() %>" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= admin.getEmail() %>" required>
            </div>
            
            <div class="buttons">
                <input type="submit" value="Update Details">
                <a href="adminDashboard.jsp">Back to Dashboard</a>
            </div>
        </form>
    </div>
</body>
</html>