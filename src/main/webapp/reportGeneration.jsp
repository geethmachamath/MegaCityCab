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

    int driverCount = 0;
    int passengerCount = 0;
    double totalRevenue = 0.0;
    double avgBookingAmount = 0.0;
    int completedBookings = 0;
    int pendingBookings = 0;
    int cancelledBookings = 0;

    // Monthly revenue data (last 6 months)
    String[] months = new String[6];
    double[] monthlyRevenue = new double[6];
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMM yyyy");

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        // User counts
        Statement driverStmt = conn.createStatement();
        ResultSet driverRs = driverStmt.executeQuery("SELECT COUNT(*) as count FROM employees WHERE type = 'driver'");
        if (driverRs.next()) driverCount = driverRs.getInt("count");

        Statement passengerStmt = conn.createStatement();
        ResultSet passengerRs = passengerStmt.executeQuery("SELECT COUNT(*) as count FROM users");
        if (passengerRs.next()) passengerCount = passengerRs.getInt("count");

        // Financial data
        Statement revenueStmt = conn.createStatement();
        ResultSet revenueRs = revenueStmt.executeQuery("SELECT SUM(totalAmount) as total, AVG(totalAmount) as avg FROM bookings WHERE status = 'completed'");
        if (revenueRs.next()) {
            totalRevenue = revenueRs.getDouble("total");
            avgBookingAmount = revenueRs.getDouble("avg");
        }

        // Booking status distribution
        Statement statusStmt = conn.createStatement();
        ResultSet statusRs = statusStmt.executeQuery("SELECT status, COUNT(*) as count FROM bookings GROUP BY status");
        while (statusRs.next()) {
            String status = statusRs.getString("status").toLowerCase();
            int count = statusRs.getInt("count");
            if ("completed".equals(status)) completedBookings = count;
            else if ("pending".equals(status)) pendingBookings = count;
            else if ("cancelled".equals(status)) cancelledBookings = count;
        }

        // Monthly revenue (fixed query)
        PreparedStatement monthlyStmt = conn.prepareStatement(
            "SELECT DATE_FORMAT(booked_date, '%b %Y') as month_year, SUM(totalAmount) as revenue " +
            "FROM bookings " +
            "WHERE booked_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AND status = 'completed' " +
            "GROUP BY DATE_FORMAT(booked_date, '%b %Y'), YEAR(booked_date), MONTH(booked_date) " +
            "ORDER BY YEAR(booked_date) DESC, MONTH(booked_date) DESC " +
            "LIMIT 6"
        );
        ResultSet monthlyRs = monthlyStmt.executeQuery();
        int i = 5;
        while (monthlyRs.next() && i >= 0) {
            months[i] = monthlyRs.getString("month_year");
            monthlyRevenue[i] = monthlyRs.getDouble("revenue");
            i--;
        }
        while (i >= 0) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.add(java.util.Calendar.MONTH, -i);
            months[i] = sdf.format(cal.getTime());
            monthlyRevenue[i] = 0.0;
            i--;
        }
    } catch (SQLException e) {
        out.println("Database error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Reports - Mega City Cabs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            text-align: center;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: var(--primary-teal);
        }

        /* Stats */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .stat-box {
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: rgba(255, 132, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: var(--primary-teal);
            font-size: 1.5rem;
        }

        .stat-box h3 {
            font-size: 1rem;
            color: #666;
            margin-bottom: 10px;
        }

        .stat-box p {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-teal);
            margin: 0;
        }

        /* Chart Container */
        .chart-container {
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 50px;
        }

        .charts-row {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: space-between;
        }

        .chart-container canvas {
            max-width: 100%;
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

            .stats {
                grid-template-columns: 1fr;
            }

            .charts-row {
                flex-direction: column;
            }

            .chart-container {
                padding: 20px;
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
            <h1>System Reports</h1>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Summary Statistics -->
        <h3 class="section-title">Summary Statistics</h3>
        <div class="stats">
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-id-card"></i></div>
                <h3>Total Drivers</h3>
                <p><%= driverCount %></p>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <h3>Total Passengers</h3>
                <p><%= passengerCount %></p>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-money-bill-wave"></i></div>
                <h3>Total Revenue</h3>
                <p>Rs. <%= String.format("%.2f", totalRevenue) %></p>
            </div>
            <div class="stat-box">
                <div class="stat-icon"><i class="fas fa-calculator"></i></div>
                <h3>Avg. Booking</h3>
                <p>Rs. <%= String.format("%.2f", avgBookingAmount) %></p>
            </div>
        </div>

        <!-- Charts -->
        <h3 class="section-title">Visual Insights</h3>
        <div class="charts-row">
            <!-- Pie Chart: User Distribution -->
            <div class="chart-container" style="flex: 1; min-width: 300px;">
                <canvas id="userDistributionChart"></canvas>
            </div>

            <!-- Pie Chart: Booking Status -->
            <div class="chart-container" style="flex: 1; min-width: 300px;">
                <canvas id="bookingStatusChart"></canvas>
            </div>
        </div>

        <!-- Line Chart: Monthly Revenue -->
        <div class="chart-container">
            <canvas id="monthlyRevenueChart"></canvas>
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

    <!-- Chart.js Scripts -->
    <script>
        // Pie Chart: User Distribution
        new Chart(document.getElementById('userDistributionChart').getContext('2d'), {
            type: 'pie',
            data: {
                labels: ['Drivers', 'Passengers'],
                datasets: [{
                    data: [<%= driverCount %>, <%= passengerCount %>],
                    backgroundColor: ['rgba(54, 162, 235, 0.8)', 'rgba(255, 99, 132, 0.8)'],
                    borderColor: ['rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'top' },
                    title: { display: true, text: 'User Distribution' }
                }
            }
        });

        // Pie Chart: Booking Status
        new Chart(document.getElementById('bookingStatusChart').getContext('2d'), {
            type: 'pie',
            data: {
                labels: ['Completed', 'Pending', 'Cancelled'],
                datasets: [{
                    data: [<%= completedBookings %>, <%= pendingBookings %>, <%= cancelledBookings %>],
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.8)',
                        'rgba(255, 206, 86, 0.8)',
                        'rgba(255, 99, 132, 0.8)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(255, 99, 132, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'top' },
                    title: { display: true, text: 'Booking Status Distribution' }
                }
            }
        });

        // Line Chart: Monthly Revenue
        new Chart(document.getElementById('monthlyRevenueChart').getContext('2d'), {
            type: 'line',
            data: {
                labels: [<%= "\"" + String.join("\", \"", months) + "\"" %>],
                datasets: [{
                    label: 'Revenue (Rs.)',
                    data: [<%= String.join(", ", java.util.Arrays.stream(monthlyRevenue).mapToObj(String::valueOf).toArray(String[]::new)) %>],
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: 'Revenue (Rs.)' }
                    },
                    x: {
                        title: { display: true, text: 'Month' }
                    }
                },
                plugins: {
                    legend: { display: true },
                    title: { display: true, text: 'Monthly Revenue (Last 6 Months)' }
                }
            }
        });
    </script>
</body>
</html>