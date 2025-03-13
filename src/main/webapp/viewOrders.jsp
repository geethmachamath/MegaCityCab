<%@ page import="java.util.List, com.login.model.Booking" %>
<%@ page import="com.login.model.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<% 
    Employee driver = (Employee) session.getAttribute("employee");
    if (driver == null || !"driver".equals(driver.getType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders - Mega City Cabs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --primary-teal: #FF8400;
            --secondary-teal: #FFA801;
            --dark-teal: #FF9000;
            --white: #FFFFFF;
            --light-bg: #F5F7FA;
            --soft-gray: #ECEFF1;
            --dark-gray: #263238;
            --black: #1A1A1A;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            color: var(--dark-gray);
            background: var(--light-bg);
            line-height: 1.6;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background: var(--black);
            color: var(--white);
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo img {
            height: 50px;
            transition: transform 0.3s ease;
        }

        .logo img:hover {
            transform: rotate(10deg) scale(1.1);
        }

        .logo span {
            font-size: 1.5rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            background: var(--white);
            color: var(--black);
        }

        .logout-btn {
            background: var(--primary-teal);
            color: var(--white);
            border: none;
            padding: 12px 40px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: var(--dark-teal);
            transform: scale(1.05);
        }

        /* Hero Section */
        .hero-section {
            height: 400px;
            background: url('images/audi.jpg') no-repeat center/cover;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--white);
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.4);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-content h1 {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 50px 40px;
            max-width: 1300px;
            margin: 0 auto;
            width: 100%;
        }

        /* Section Title */
        .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 30px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--primary-teal);
        }

        /* Bookings List */
        .bookings-list {
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 50px;
        }

        .bookings-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
        }

        .bookings-table th,
        .bookings-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--soft-gray);
        }

        .bookings-table th {
            background: var(--soft-gray);
            color: var(--dark-gray);
            font-weight: 600;
        }

        .bookings-table tr:hover {
            background: var(--light-bg);
        }

        .status-pending {
            background-color: #fff3cd;
        }

        .status-confirmed {
            background-color: #d4edda;
        }

        .status-completed {
            background-color: #d1ecf1;
        }

        .status-cancelled {
            background-color: #f8d7da;
        }

        .form-inline {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .form-inline select {
            padding: 8px;
            border: 1px solid var(--soft-gray);
            border-radius: 10px;
            font-size: 0.95rem;
            color: var(--dark-gray);
            transition: border-color 0.3s ease;
        }

        .form-inline select:focus {
            border-color: var(--primary-teal);
            outline: none;
        }

        .update-btn {
            background: var(--black);
            color: var(--white);
            border: none;
            padding: 8px 15px;
            border-radius: 50px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .update-btn:hover {
            background: var(--white);
            border: 1px solid var(--black);
            color: var(--black);
            transform: scale(1.05);
        }

        .no-bookings {
            text-align: center;
            font-size: 1.2rem;
            color: #666;
            padding: 40px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: var(--dark-teal);
            text-decoration: underline;
        }

        /* Footer */
        footer {
            background: var(--black);
            color: var(--white);
            padding: 40px 20px;
            margin-top: auto;
        }

        .footer-content {
            max-width: 1300px;
            margin: 0 auto;
            text-align: center;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
            padding: 5px 10px;
            transition: all 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary-teal);
        }

        .copyright {
            font-size: 0.9rem;
            opacity: 0.8;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 20px;
                gap: 20px;
            }

            .main-content {
                padding: 30px 20px;
            }

            .hero-section {
                height: 300px;
            }

            .hero-content h1 {
                font-size: 2rem;
            }

            .bookings-table {
                font-size: 0.9rem;
            }

            .bookings-table th,
            .bookings-table td {
                padding: 10px;
            }

            .form-inline {
                flex-direction: column;
                align-items: flex-start;
            }

            .form-inline select,
            .form-inline .update-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <a href="driverDashboard.jsp"><img src="images/logo.png" alt="Company Logo"></a>
         </div>
        <div class="nav-links">
            <a href="ViewOrdersServlet">View Orders</a>
            <a href="myDetails.jsp">My Details</a>
        </div>
        <form action="LogoutServlet" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1>Your Orders</h1>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h3 class="section-title">Assigned Bookings</h3>
        <div class="bookings-list">
            <% if (bookings == null || bookings.isEmpty()) { %>
                <div class="no-bookings">
                    <i class="fas fa-exclamation-circle" style="font-size: 2rem; color: var(--primary-teal); margin-bottom: 15px;"></i>
                    <p>No bookings assigned to you at the moment.</p>
                </div>
            <% } else { %>
                <table class="bookings-table">
                    <thead>
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
                    </thead>
                    <tbody>
                        <% for (Booking booking : bookings) {
                            String status = booking.getStatus().toLowerCase();
                            String statusClass = "";
                            if ("pending".equals(status)) {
                                statusClass = "status-pending";
                            } else if ("confirmed".equals(status)) {
                                statusClass = "status-confirmed";
                            } else if ("completed".equals(status)) {
                                statusClass = "status-completed";
                            } else if ("cancelled".equals(status)) {
                                statusClass = "status-cancelled";
                            }
                        %>
                        <tr class="<%= statusClass %>">
                            <td><%= booking.getId() %></td>
                            <td><%= booking.getName() %></td>
                            <td><%= booking.getPhone() %></td>
                            <td><%= booking.getPickup() %></td>
                            <td><%= booking.getDropLocation() %></td>
                            <td><%= booking.getKms() %></td>
                            <td><%= booking.getCabId() %></td>
                            <td><%= booking.getStatus() %></td>
                            <td><%= booking.getBookedDate() != null ? booking.getBookedDate() : "N/A" %></td>
                            <td>
                                <form action="UpdateOrderStatusServlet" method="post" class="form-inline">
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
                    </tbody>
                </table>
            <% } %>
        </div>
        <a href="driverDashboard.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-links">
                <a href="about.jsp">About Us</a>
                <a href="contact.jsp">Contact</a>
                <a href="help.jsp">Help</a>
                <a href="privacy.jsp">Privacy Policy</a>
                <a href="terms.jsp">Terms of Service</a>
            </div>
            <div class="copyright">
                © <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> Mega City Cabs. All rights reserved.
            </div>
        </div>
    </footer>
</body>
</html>