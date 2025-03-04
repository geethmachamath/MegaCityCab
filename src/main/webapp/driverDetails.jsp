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

String successMessage = "";
String errorMessage = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (name != null && email != null && password != null) {
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM employees WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet checkRs = checkStmt.executeQuery();
            
            if (checkRs.next()) {
                errorMessage = "Email already exists!";
            } else {
                PreparedStatement insertStmt = conn.prepareStatement(
                    "INSERT INTO employees (name, email, password, type) VALUES (?, ?, ?, 'driver')",
                    Statement.RETURN_GENERATED_KEYS);
                insertStmt.setString(1, name);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password);
                
                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    successMessage = "Driver added successfully!";
                }
            }
        } catch (SQLException e) {
            errorMessage = "Database error: " + e.getMessage();
        }
    } else {
        errorMessage = "All fields are required!";
    }
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Management</title>
    <style>
        /* Same CSS as before */
    </style>
</head>
<body>
    <div class="container">
        <h2>Driver Management</h2>
        <a href="adminDashboard.jsp" class="nav-link">← Back to Dashboard</a>
        
        <% if (!successMessage.isEmpty()) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>
        
        <h3>Driver List</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT id, name, email FROM employees WHERE type = 'driver'");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="editDriver.jsp?id=<%= rs.getInt("id") %>">Edit</a> | 
                        <a href="deleteDriver.jsp?id=<%= rs.getInt("id") %>" 
                           onclick="return confirm('Are you sure you want to delete this driver?')">Delete</a>
                    </td>
                </tr>
                <% 
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                }
                %>
            </tbody>
        </table>
        
        <div class="form-container">
            <h3>Add New Driver</h3>
            <form method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">Add Driver</button>
            </form>
        </div>
    </div>
</body>
</html>