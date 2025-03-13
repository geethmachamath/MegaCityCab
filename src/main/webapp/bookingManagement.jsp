<%@ page import="com.login.model.Employee" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Employee admin = (Employee) session.getAttribute("employee");
    if (admin == null || !"admin".equals(admin.getType())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/login_system";
    String dbUser = "root";
    String dbPassword = "1234";

    // Message variables for feedback
    String successMessage = "";
    String errorMessage = "";

    // Process form submission for updating booking status
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null && request.getParameter("action").equals("update")) {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String totalAmount = request.getParameter("totalAmount");
        
        try {
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            
            PreparedStatement updateStmt = conn.prepareStatement(
                "UPDATE bookings SET status = ?, totalAmount = ? WHERE id = ?");
            updateStmt.setString(1, status);
            updateStmt.setString(2, totalAmount);
            updateStmt.setInt(3, bookingId);
            
            int rowsAffected = updateStmt.executeUpdate();
            if (rowsAffected > 0) {
                successMessage = "Booking updated successfully!";
            } else {
                errorMessage = "Failed to update booking!";
            }
            
            updateStmt.close();
            conn.close();
        } catch (SQLException e) {
            errorMessage = "Database error: " + e.getMessage();
        } catch (NumberFormatException e) {
            errorMessage = "Invalid input format!";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Management - Mega City Cabs</title>
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

        /* Messages */
        .success-message {
            background: #E0F7F6;
            color: var(--dark-teal);
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.5s ease;
        }

        .success-message::before {
            content: '\f058';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 1.2rem;
        }

        .error-message {
            background: #FFE0E0;
            color: #D32F2F;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: fadeIn 0.5s ease;
        }

        .error-message::before {
            content: '\f06a';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 1.2rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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

        .form-inline select,
        .form-inline input {
            padding: 8px;
            border: 1px solid var(--soft-gray);
            border-radius: 10px;
            font-size: 0.95rem;
            color: var(--dark-gray);
            transition: border-color 0.3s ease;
        }

        .form-inline select:focus,
        .form-inline input:focus {
            border-color: var(--primary-teal);
            outline: none;
        }

        .form-inline button {
            background: var(--black);
            color: var(--white);
            border: none;
            padding: 8px 15px;
            border-radius: 50px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-inline button:hover {
            background: var(--white);
            border: 1px solid var(--black);
            color: var(--black);
            transform: scale(1.05);
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
            .form-inline input,
            .form-inline button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <a href="adminDashboard.jsp"><img src="images/logo.png" alt="Company Logo"></a>
            
        </div>
        <div class="nav-links">
            <a href="driverDetails.jsp">Driver Details</a>
            <a href="passengerDetails.jsp">Passenger Details</a>
            <a href="bookingManagement.jsp">Booking Management</a>
            <a href="reportGeneration.jsp">Reports</a>
        </div>
        <form action="logout.jsp" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h1>Booking Management</h1>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Messages -->
        <% if (!successMessage.isEmpty()) { %>
            <div class="success-message"><%= successMessage %></div>
        <% } %>
        <% if (!errorMessage.isEmpty()) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>

        <!-- Bookings List -->
        <h3 class="section-title">All Bookings</h3>
        <div class="bookings-list">
            <table class="bookings-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Pickup</th>
                        <th>Drop Location</th>
                        <th>KMs</th>
                        <th>Cab ID</th>
                        <th>Status</th>
                        <th>Total Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    try {
                        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM bookings ORDER BY id DESC");
                        
                        while (rs.next()) {
                            String status = rs.getString("status");
                            String statusClass = "";
                            
                            if ("pending".equalsIgnoreCase(status)) {
                                statusClass = "status-pending";
                            } else if ("confirmed".equalsIgnoreCase(status)) {
                                statusClass = "status-confirmed";
                            } else if ("completed".equalsIgnoreCase(status)) {
                                statusClass = "status-completed";
                            } else if ("cancelled".equalsIgnoreCase(status)) {
                                statusClass = "status-cancelled";
                            }
                    %>
                    <tr class="<%= statusClass %>">
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("phone") %></td>
                        <td><%= rs.getString("pickup") %></td>
                        <td><%= rs.getString("dropLocation") %></td>
                        <td><%= rs.getInt("kms") %></td>
                        <td><%= rs.getInt("cab_id") %></td>
                        <td>
                            <form method="post" action="bookingManagement.jsp" class="form-inline">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                <select name="status">
                                    <option value="pending" <%= "pending".equalsIgnoreCase(status) ? "selected" : "" %>>Pending</option>
                                    <option value="confirmed" <%= "confirmed".equalsIgnoreCase(status) ? "selected" : "" %>>Confirmed</option>
                                    <option value="completed" <%= "completed".equalsIgnoreCase(status) ? "selected" : "" %>>Completed</option>
                                    <option value="cancelled" <%= "cancelled".equalsIgnoreCase(status) ? "selected" : "" %>>Cancelled</option>
                                </select>
                                <input type="text" name="totalAmount" value="<%= rs.getBigDecimal("totalAmount") %>" placeholder="Amount" size="8">
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        <td><%= rs.getBigDecimal("totalAmount") %></td>
                    </tr>
                    <% 
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (SQLException e) {
                        out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                    }
                    %>
                </tbody>
            </table>
        </div>
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