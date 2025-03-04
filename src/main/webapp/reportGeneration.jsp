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
<html>
<head>
    <title>System Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            width: 90%;
            margin: 0 auto;
            max-width: 1200px;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .chart-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .nav-link {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #007bff;
            font-size: 16px;
        }
        .nav-link:hover {
            text-decoration: underline;
        }
        .stats {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-bottom: 30px;
            gap: 20px;
        }
        .stat-box {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            width: 200px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .stat-box h3 {
            margin: 0 0 10px 0;
            color: #666;
            font-size: 16px;
        }
        .stat-box p {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container">
        <h2>System Reports</h2>
        <a href="adminDashboard.jsp" class="nav-link">← Back to Dashboard</a>

        <!-- Summary Statistics -->
        <div class="stats">
            <div class="stat-box">
                <h3>Total Drivers</h3>
                <p><%= driverCount %></p>
            </div>
            <div class="stat-box">
                <h3>Total Passengers</h3>
                <p><%= passengerCount %></p>
            </div>
            <div class="stat-box">
                <h3>Total Revenue</h3>
                <p>Rs. <%= String.format("%.2f", totalRevenue) %></p>
            </div>
            <div class="stat-box">
                <h3>Avg. Booking</h3>
                <p>Rs. <%= String.format("%.2f", avgBookingAmount) %></p>
            </div>
        </div>

        <!-- Charts Container -->
        <div style="display: flex; flex-wrap: wrap; gap: 30px;">
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