<%@ page import="com.login.model.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Employee driver = (Employee) session.getAttribute("employee");
    if (driver == null || !"driver".equals(driver.getType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard - Mega City Cabs</title>
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

        /* Welcome Banner */
        .welcome-banner {
            background: var(--white);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 50px;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            border-left: 6px solid var(--primary-teal);
        }

        .welcome-banner h2 {
            font-size: 2.2rem;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 15px;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            color: var(--dark-gray);
            max-width: 700px;
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

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .action-card {
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .action-icon {
            color: var(--primary-teal);
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .action-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 10px;
        }

        .action-desc {
            font-size: 0.95rem;
            color: #666;
            margin-bottom: 20px;
        }

        .action-btn {
            background: var(--black);
            color: var(--white);
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            align-self: flex-start;
        }

        .action-btn:hover {
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

            .welcome-banner {
                padding: 25px;
            }

            .welcome-banner h2 {
                font-size: 1.8rem;
            }

            .quick-actions {
                grid-template-columns: 1fr;
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
            <h1>Driver Dashboard</h1>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <h2>Welcome, <%= driver.getName() %>!</h2>
            <p>Manage your orders and personal details from your driver dashboard.</p>
        </div>

        <!-- Quick Actions -->
        <h3 class="section-title">Quick Actions</h3>
        <div class="quick-actions">
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-clipboard-list"></i></div>
                <div class="action-title">View Orders</div>
                <div class="action-desc">Check your assigned bookings and update their status.</div>
                <a href="ViewOrdersServlet" class="action-btn">View Orders</a>
            </div>
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-user"></i></div>
                <div class="action-title">My Details</div>
                <div class="action-desc">View and update your personal information.</div>
                <a href="myDetails.jsp" class="action-btn">My Details</a>
            </div>
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-sign-out-alt"></i></div>
                <div class="action-title">Logout</div>
                <div class="action-desc">End your session securely.</div>
                <a href="logout.jsp" class="action-btn">Logout</a>
            </div>
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