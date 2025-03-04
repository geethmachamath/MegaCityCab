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
    String address = request.getParameter("address");
    String nic = request.getParameter("nic");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (name != null && email != null && password != null && address != null && nic != null) {
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet checkRs = checkStmt.executeQuery();
            
            if (checkRs.next()) {
                errorMessage = "Email already exists!";
            } else {
                PreparedStatement insertStmt = conn.prepareStatement(
                    "INSERT INTO users (name, address, nic, email, password) VALUES (?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
                insertStmt.setString(1, name);
                insertStmt.setString(2, address);
                insertStmt.setString(3, nic);
                insertStmt.setString(4, email);
                insertStmt.setString(5, password);
                
                int rowsAffected = insertStmt.executeUpdate();
                if (rowsAffected > 0) {
                    successMessage = "Passenger added successfully!";
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
    <title>Passenger Management</title>
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
        <h2>Passenger Management</h2>
        <a href="adminDashboard.jsp" class="nav-link">← Back to Dashboard</a>
        
        <% if (!successMessage.isEmpty()) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>
        
        <h3>Passenger List</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>NIC</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT id, name, address, nic, email FROM users");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("nic") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="editPassenger.jsp?id=<%= rs.getInt("id") %>">Edit</a> | 
                        <a href="deletePassenger.jsp?id=<%= rs.getInt("id") %>" 
                           onclick="return confirm('Are you sure you want to delete this passenger?')">Delete</a>
                    </td>
                </tr>
                <% 
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                }
                %>
            </tbody>
        </table>
        
        <div class="form-container">
            <h3>Add New Passenger</h3>
            <form method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="form-group">
                    <label for="nic">NIC:</label>
                    <input type="text" id="nic" name="nic" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">Add Passenger</button>
            </form>
        </div>
    </div>
</body>
</html>