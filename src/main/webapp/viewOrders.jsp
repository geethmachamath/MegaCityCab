<%@ page import="java.util.List, com.login.model.Booking" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% 
List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Orders</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        p { color: #666; }
        select { padding: 5px; }
        .update-btn { background-color: #007bff; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .update-btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <h2>Your Bookings</h2>
    <% if (bookings == null || bookings.isEmpty()) { %>
        <p>No bookings found for your cabs.</p>
    <% } else { %>
        <table>
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Phone</th>
                <th>Pickup</th>
                <th>Drop Location</th>
                <th>KMs</th>
                <th>Cab ID</th>
                <th>Status</th>
                <th>Booked Date</th>
                <th>Update Status</th>
            </tr>
            <% for (Booking booking : bookings) { %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getName() %></td>
                    <td><%= booking.getPhone() %></td>
                    <td><%= booking.getPickup() %></td>
                    <td><%= booking.getDropLocation() %></td>
                    <td><%= booking.getKms() %></td>
                    <td><%= booking.getCabId() %></td>
                    <td><%= booking.getStatus() %></td>
                    <td><%= booking.getBookedDate() %></td>
                    <td>
                        <form action="UpdateOrderStatusServlet" method="post">
                            <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                            <select name="status">
                                <option value="pending" <%= "pending".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="confirmed" <%= "confirmed".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                <option value="completed" <%= "completed".equals(booking.getStatus()) ? "selected" : "" %>>Completed</option>
                                <option value="cancelled" <%= "cancelled".equals(booking.getStatus()) ? "selected" : "" %>>Cancelled</option>
                            </select>
                            <button type="submit" class="update-btn">Update</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } %>
    <p><a href="driverDashboard.jsp">Back to Dashboard</a></p>
</body>
</html>