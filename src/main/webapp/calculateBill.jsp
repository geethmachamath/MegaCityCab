<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculate Bill - Mega City Cabs</title>
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
            background: var(--light-bg);
            color: var(--dark-gray);
            line-height: 1.6;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background: #000000;
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
            color: black;
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

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 50px 40px;
            max-width: 1300px;
            margin: 0 auto;
            width: 100%;
        }

        /* Bill Container */
        .bill-container {
            background: var(--white);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            border-left: 6px solid var(--primary-teal);
            max-width: 500px;
            margin: 0 auto;
        }

        .bill-title {
            color: var(--dark-gray);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
            font-weight: 600;
        }

        .bill-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding: 10px 0;
            border-bottom: 1px solid var(--soft-gray);
        }

        .bill-item span:first-child {
            font-weight: 500;
            color: var(--dark-gray);
        }

        .bill-item span:last-child {
            color: var(--dark-teal);
        }

        .total {
            font-weight: 600;
            border-top: 2px solid var(--primary-teal);
            padding-top: 15px;
            margin-top: 20px;
            font-size: 1.2rem;
        }

        .total span:last-child {
            color: var(--primary-teal);
        }

        .confirm-btn {
            width: 100%;
            padding: 12px;
            background: var(--primary-teal);
            color: var(--white);
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-top: 20px;
        }

        .confirm-btn:hover {
            background: var(--dark-teal);
            transform: scale(1.05);
        }

        /* Footer */
        footer {
            background: black;
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

            .bill-container {
                padding: 25px;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <img src="images/logo.png" alt="Company Logo">
            <span>Cab</span>
        </div>
        <div class="nav-links">
            <a href="bookVehicle.jsp">Book Vehicle</a>
            <a href="viewBookingHistory.jsp">History</a>
            <a href="myDetails.jsp">My Account</a>
        </div>
        <form action="logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="bill-container">
            <h2 class="bill-title">Booking Details</h2>
            
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
                <span>Amount (150 LKR per km):</span>
                <span>LKR <%= String.format("%.2f", session.getAttribute("amount")) %></span>
            </div>
            
            <div class="bill-item">
                <span>Tax (8%):</span>
                <span>LKR <%= String.format("%.2f", session.getAttribute("tax")) %></span>
            </div>
            
            <div class="bill-item total">
                <span>Total Amount:</span>
                <span>LKR <%= String.format("%.2f", session.getAttribute("totalAmount")) %></span>
            </div>
            
            <form action="BookingConfirmServlet" method="post">
                <input type="hidden" name="bookingId" value="<%= session.getAttribute("bookingId") %>">
                <input type="hidden" name="totalAmount" value="<%= session.getAttribute("totalAmount") %>">
                <button type="submit" class="confirm-btn">Confirm Booking</button>
            </form>
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