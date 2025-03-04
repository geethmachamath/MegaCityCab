<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculate Bill</title>
    <style>
        .bill-container {
            width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .bill-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .total {
            font-weight: bold;
            border-top: 1px solid #ccc;
            padding-top: 10px;
        }
    </style>
</head>
<body>
    <div class="bill-container">
        <h2>Booking Details</h2>
        
        <div class="bill-item">
            <span>Booking ID:</span>
            <span><%= session.getAttribute("bookingId") %></span>
        </div>
        
        <div class="bill-item">
            <span>Name:</span>
            <span><%= session.getAttribute("name") %></span>
        </div>
        
        <div class="bill-item">
            <span>Pickup Location:</span>
            <span><%= session.getAttribute("pickup") %></span>
        </div>
        
        <div class="bill-item">
            <span>Drop Location:</span>
            <span><%= session.getAttribute("dropLocation") %></span>
        </div>
        
        <div class="bill-item">
            <span>Distance (km):</span>
            <span><%= session.getAttribute("kms") %></span>
        </div>
        
        <div class="bill-item">
            <span>Cab Model:</span>
            <span><%= session.getAttribute("cabModel") %></span>
        </div>
        
        <div class="bill-item">
            <span>Amount (₹150 per km):</span>
            <span>₹ <%= String.format("%.2f", session.getAttribute("amount")) %></span>
        </div>
        
        <div class="bill-item">
            <span>Tax (8%):</span>
            <span>₹ <%= String.format("%.2f", session.getAttribute("tax")) %></span>
        </div>
        
        <div class="bill-item total">
            <span>Total Amount:</span>
            <span>₹ <%= String.format("%.2f", session.getAttribute("totalAmount")) %></span>
        </div>
        
        <form action="BookingConfirmServlet" method="post">
            <input type="hidden" name="bookingId" value="<%= session.getAttribute("bookingId") %>">
            <input type="hidden" name="totalAmount" value="<%= session.getAttribute("totalAmount") %>">
            <input type="submit" value="Confirm Booking" style="margin-top: 20px; padding: 10px; width: 100%;">
        </form>
    </div>
</body>
</html>