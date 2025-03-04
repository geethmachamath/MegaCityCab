<%@ page import="com.login.model.Employee" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
Employee admin = (Employee) session.getAttribute("employee");
if (admin == null || !"admin".equals(admin.getType())) {
    response.sendRedirect("login.jsp");
    return;
}

String dbURL = "jdbc:mysql://localhost:3306/login_system";
String dbUser = "root";
String dbPassword = "1234";

String id = request.getParameter("id");
String successMessage = "";
String errorMessage = "";

if ("POST".equalsIgnoreCase(request.getMethod()) && id != null) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        PreparedStatement stmt = conn.prepareStatement(
            "UPDATE employees SET name = ?, email = ?, password = ? WHERE id = ? AND type = 'driver'");
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, password);
        stmt.setInt(4, Integer.parseInt(id));
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            successMessage = "Driver updated successfully!";
        } else {
            errorMessage = "Failed to update driver!";
        }
    } catch (SQLException e) {
        errorMessage = "Database error: " + e.getMessage();
    }
}

String name = "";
String email = "";
try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
    PreparedStatement stmt = conn.prepareStatement("SELECT name, email FROM employees WHERE id = ? AND type = 'driver'");
    stmt.setInt(1, Integer.parseInt(id));
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        name = rs.getString("name");
        email = rs.getString("email");
    }
} catch (SQLException e) {
    errorMessage = "Error loading driver data: " + e.getMessage();
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Driver</title>
    <style>
        /* Same CSS as before */
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Driver</h2>
        <a href="driverDetails.jsp" class="nav-link">← Back to Driver Management</a>
        
        <% if (!successMessage.isEmpty()) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>
        
        <div class="form-container">
            <form method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">Update Driver</button>
            </form>
        </div>
    </div>
</body>
</html>