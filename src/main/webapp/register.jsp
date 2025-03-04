<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
</head>
<body>
    <h2>Register as a User</h2>
    <form action="register" method="post">
        <label>Name:</label>
        <input type="text" name="name" required><br>

        <label>Address:</label>
        <input type="text" name="address" required><br>

        <label>NIC:</label>
        <input type="text" name="nic" required><br>

        <label>Email:</label>
        <input type="email" name="email" required><br>

        <label>Password:</label>
        <input type="password" name="password" required><br>

        <input type="submit" value="Register">
    </form>

    <p>Already have an account? <a href="login.jsp">Login here</a></p>

    <%-- Display error/success messages --%>
    <% if (request.getParameter("msg") != null) { %>
        <% if ("success".equals(request.getParameter("msg"))) { %>
            <p style="color:green;">Registration successful! Please log in.</p>
        <% } else { %>
            <p style="color:red;">Registration failed. Try again.</p>
        <% } %>
    <% } %>
</body>
</html>
