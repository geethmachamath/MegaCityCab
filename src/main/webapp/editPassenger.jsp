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
    String address = request.getParameter("address");
    String nic = request.getParameter("nic");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        PreparedStatement stmt = conn.prepareStatement(
            "UPDATE users SET name = ?, address = ?, nic = ?, email = ?, password = ? WHERE id = ?");
        stmt.setString(1, name);
        stmt.setString(2, address);
        stmt.setString(3, nic);
        stmt.setString(4, email);
        stmt.setString(5, password);
        stmt.setInt(6, Integer.parseInt(id));
        
        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            successMessage = "Passenger updated successfully!";
        } else {
            errorMessage = "Failed to update passenger!";
        }
    } catch (SQLException e) {
        errorMessage = "Database error: " + e.getMessage();
    }
}

String name = "";
String address = "";
String nic = "";
String email = "";
try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
    PreparedStatement stmt = conn.prepareStatement("SELECT name, address, nic, email FROM users WHERE id = ?");
    stmt.setInt(1, Integer.parseInt(id));
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        name = rs.getString("name");
        address = rs.getString("address");
        nic = rs.getString("nic");
        email = rs.getString("email");
    }
} catch (SQLException e) {
    errorMessage = "Error loading passenger data: " + e.getMessage();
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Passenger</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            width: 90%;
            margin: 0 auto;
        }
        .form-container {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Passenger</h2>
        <a href="passengerDetails.jsp" class="nav-link">← Back to Passenger Management</a>
        
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
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= address %>" required>
                </div>
                <div class="form-group">
                    <label for="nic">NIC:</label>
                    <input type="text" id="nic" name="nic" value="<%= nic %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">Update Passenger</button>
            </form>
        </div>
    </div>
</body>
</html>