<%@ page import="com.login.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Details</title>
</head>
<body>
    <h2>My Details</h2>
    
    <% if ("true".equals(success)) { %>
        <p style="color: green;">Details updated successfully!</p>
    <% } else if ("updateFailed".equals(error)) { %>
        <p style="color: red;">Failed to update details. Try again.</p>
    <% } else if ("emptyFields".equals(error)) { %>
        <p style="color: red;">All fields are required!</p>
    <% } %>

    <form action="UpdateUserServlet" method="post">
        <label>Name:</label>
        <input type="text" name="name" value="<%= user.getName() %>" required><br>

        <label>Address:</label>
        <input type="text" name="address" value="<%= user.getAddress() %>" required><br>

        <label>NIC:</label>
        <input type="text" name="nic" value="<%= user.getNic() %>" required><br>

        <label>Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required readonly><br>

        <input type="submit" value="Update">
    </form>
</body>
</html>
