<%@ page import="java.sql.*, com.login.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
Connection con = DBConnection.getConnection();
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM cabs");
%>

<!DOCTYPE html>
<html>
<head>
<title>Book a Vehicle</title>
<style>
    .error-message {
        color: red;
        margin-bottom: 15px;
        padding: 10px;
        background-color: #ffeeee;
        border-radius: 5px;
    }
</style>
</head>
<body>
<h2>Book a Vehicle</h2>

<% if (request.getParameter("error") != null) { 
    String error = request.getParameter("error");
%>
    <div class="error-message">
        <% if (error.equals("connection")) { %>
            Booking Failed! Database connection error. Please try again later.
        <% } else if (error.equals("insert")) { %>
            Booking Failed! Could not save your booking. Please try again.
        <% } else { %>
            Booking Failed! Error: <%= error %> Please try again.
        <% } %>
    </div>
<% } %>

<form action="BookingServlet" method="post">
<label>Name:</label>
<input type="text" name="name" required><br>

<label>Email:</label>
<input type="email" name="email" required><br>

<label>Phone:</label>
<input type="text" name="phone" required><br>

<label>Pickup Location:</label>
<input type="text" name="pickup" required><br>

<label>Drop Location:</label>
<input type="text" name="dropLocation" required><br>

<label>Kms:</label>
<input type="number" name="kms" min="1" required><br>

<label>Choose a Cab:</label>
<select name="cab_id" required>
<% while (rs.next()) { %>
<option value="<%= rs.getInt("id") %>"><%= rs.getString("model") %></option>
<% } %>
</select><br>

<input type="submit" value="Proceed to Bill">
</form>
</body>
</html>