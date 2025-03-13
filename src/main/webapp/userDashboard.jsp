<%@ page import="com.login.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Mega City Cabs</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            color: var(--white);
            transform: scale(1.05);
        }

        /* Hero Section */
        .hero-section {
            height: 600px;
            background: url('images/bgg.png') no-repeat center/cover;
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
            background: rgba(0, 0, 0, 0.05);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            height: 100%;
            justify-content: space-between;
            padding: 40px 0;
        }

        .hero-content h1 {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        .hero-car {
            position: absolute;
            right: 15%;
            top: 50%;
            transform: translateY(-50%);
            width: 300px;
            z-index: 2;
            border-radius: 60px;
            transition: all 0.5s ease;
        }

        .hero-car:hover {
            transform: translateY(-50%) scale(1.1);
        }

        .hero-book-btn {
            background: var(--primary-teal);
            color: var(--white);
            text-decoration: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: absolute;
            left: 3%;
            bottom: 90px;
            z-index: 2;
        }

        .hero-book-btn:hover {
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
            background: url("images/sss.png") repeat-y center top;
            background-size: contain;
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
            color: black;
            margin-bottom: 15px;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            color: var(--dark-gray);
            max-width: 700px;
        }

        .success-message {
            background: #E0F7F6;
            color: var(--dark-teal);
            padding: 15px 20px;
            border-radius: 10px;
            margin-top: 20px;
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

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Section Title */
        .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: black;
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
            background: black;
            color: var(--white);
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 50px;
            font-weight: 500;
            transition: all 0.3s ease;
            align-self: flex-start;
        }

        .action-btn:hover {
            background: white;
            border: 1px solid black;
            color: black;
            transform: scale(1.05);
        }

        /* Popular Destinations */
        .destinations {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .destination-card {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
        }

        .destination-card:hover {
            transform: translateY(-10px);
        }

        .destination-img {
            height: 200px;
            width: 100%;
            background-size: cover;
            background-position: center;
        }

        .destination-content {
            padding: 25px;
        }

        .destination-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 10px;
        }

        .destination-price {
            color: var(--primary-teal);
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .destination-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 20px;
            color: #FFB300;
        }

        .booking-btn {
            display: block;
            text-align: center;
            background: black;
            color: var(--white);
            padding: 10px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .booking-btn:hover {
            background: white;
            border: 1px solid black;
            color: black;
        }

        /* Company Stats */
        .company-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .company-stat-card {
            background: var(--white);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: all 0.3s ease;
        }

        .company-stat-card:hover {
            transform: translateY(-10px);
        }

        .company-stat-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: rgba(0, 196, 180, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: var(--primary-teal);
            font-size: 1.8rem;
        }

        .company-stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-teal);
            margin-bottom: 10px;
        }

        .company-stat-label {
            font-size: 1rem;
            color: #666;
        }

        /* Contact Section */
        .contact-container {
            background: var(--white);
            border-radius: 15px;
            padding: 50px;
            box-shadow: var(--shadow);
            margin-bottom: 50px;
        }

        .contact-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-gray);
            margin-bottom: 30px;
            text-align: center;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .contact-card {
            background: var(--soft-gray);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .contact-card:hover {
            transform: translateY(-10px);
            background: var(--white);
            box-shadow: var(--shadow);
        }

        .contact-icon {
            color: var(--primary-teal);
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .contact-info {
            font-size: 1.1rem;
            color: var(--dark-gray);
        }

        .contact-info a {
            color: var(--primary-teal);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .contact-info a:hover {
            color: var(--dark-teal);
            text-decoration: underline;
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

            .hero-section {
                height: 300px;
            }

            .hero-content h1 {
                font-size: 2rem;
            }

            .hero-car {
                width: 150px;
                right: 10%;
            }

            .hero-book-btn {
                left: 10%;
                bottom: 20px;
                padding: 10px 20px;
            }

            .welcome-banner {
                padding: 25px;
            }

            .welcome-banner h2 {
                font-size: 1.8rem;
            }

            .quick-actions,
            .destinations,
            .company-stats,
            .contact-grid {
                grid-template-columns: 1fr;
            }

            .contact-container {
                padding: 30px;
            }

            .contact-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <a href="userDashboard.jsp"><img src="images/logo.png" alt="Company Logo"></a>
        </div>
        <div class="nav-links">
            <a href="bookVehicle.jsp">Book Vehicle</a>
            <a href="viewBookingHistory.jsp">History</a>
            <a href="myDetails.jsp">My Account</a>
        </div>
        <form action="logout.jsp" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <img src="images/carrr.jpg" alt="Car Animation" class="hero-car">
            <a href="bookVehicle.jsp" class="hero-book-btn">Book Vehicle</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <h2>Welcome back, <%= user.getName() %>!</h2>
            <p>Your next adventure awaits—book a ride and hit the road with ease.</p>
            <% if (request.getParameter("bookingSuccess") != null) { %>
            <div class="success-message">
                Your booking has been confirmed successfully!
            </div>
            <% } %>
        </div>

        <!-- Quick Actions -->
        <h3 class="section-title">Quick Actions</h3>
        <div class="quick-actions">
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-car"></i></div>
                <div class="action-title">Book a Vehicle</div>
                <div class="action-desc">Schedule your next ride with our premium fleet.</div>
                <a href="bookVehicle.jsp" class="action-btn">Book Now</a>
            </div>
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-history"></i></div>
                <div class="action-title">View History</div>
                <div class="action-desc">Review your past rides and bookings.</div>
                <a href="viewBookingHistory.jsp" class="action-btn">View History</a>
            </div>
            <div class="action-card">
                <div class="action-icon"><i class="fas fa-user-circle"></i></div>
                <div class="action-title">My Details</div>
                <div class="action-desc">Manage your profile and preferences.</div>
                <a href="myDetails.jsp" class="action-btn">Update Profile</a>
            </div>
        </div>

        <!-- Popular Destinations -->
        <h3 class="section-title">Our Popular Cabs</h3>
        <div class="destinations">
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/bmw.jpeg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">BMW i8</h4>
                    <div class="destination-price">Colombo</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        <span>(120+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/benzcla.jpg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">Mercedez-Benz Cla 200</h4>
                    <div class="destination-price">Elpitiya</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        <span>(100+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/lexus.jpg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">Lexus 425d</h4>
                    <div class="destination-price">Nuwara Eliya</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        <span>(90+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/prius.jpg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">Toyota Prius</h4>
                    <div class="destination-price">Galle</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                        <span>(80+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/mg.jpg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">MG ZS</h4>
                    <div class="destination-price">Ambalangoda</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                        <span>(98+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
            <div class="destination-card">
                <div class="destination-img" style="background-image: url('images/audi.jpg');"></div>
                <div class="destination-content">
                    <h4 class="destination-title">Audi A5 Sport</h4>
                    <div class="destination-price">Kandy</div>
                    <div class="destination-rating">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                        <span>(85+ rides)</span>
                    </div>
                    <a href="bookVehicle.jsp" class="booking-btn">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Our Achievements -->
        <h3 class="section-title">Our Achievements</h3>
        <div class="company-stats">
            <div class="company-stat-card">
                <div class="company-stat-icon"><i class="fas fa-calendar-alt"></i></div>
                <div class="company-stat-number">10+</div>
                <div class="company-stat-label">Years of Experience</div>
            </div>
            <div class="company-stat-card">
                <div class="company-stat-icon"><i class="fas fa-smile"></i></div>
                <div class="company-stat-number">1000+</div>
                <div class="company-stat-label">Happy Clients</div>
            </div>
            <div class="company-stat-card">
                <div class="company-stat-icon"><i class="fas fa-car"></i></div>
                <div class="company-stat-number">200+</div>
                <div class="company-stat-label">Vehicles</div>
            </div>
            <div class="company-stat-card">
                <div class="company-stat-icon"><i class="fas fa-map-marker-alt"></i></div>
                <div class="company-stat-number">10+</div>
                <div class="company-stat-label">Locations</div>
            </div>
        </div>

        <!-- Contact Section -->
        <div class="contact-container">
            <h2 class="contact-title">Contact Us</h2>
            <div class="contact-grid">
                <div class="contact-card">
                    <i class="fas fa-phone contact-icon"></i>
                    <p class="contact-info">Phone: <a href="tel:+94112345678">+94 112 345 678</a></p>
                    <p class="contact-info">Available: Mon-Fri, 8 AM - 6 PM</p>
                </div>
                <div class="contact-card">
                    <i class="fas fa-envelope contact-icon"></i>
                    <p class="contact-info">Email: <a href="mailto:support@megacitycabs.com">support@megacitycabs.com</a></p>
                    <p class="contact-info">Response within 24 hours</p>
                </div>
                <div class="contact-card">
                    <i class="fas fa-map-marker-alt contact-icon"></i>
                    <p class="contact-info">Head Office: 123 City Road, Colombo 03, Sri Lanka</p>
                    <p class="contact-info">Visit us: Mon-Fri, 9 AM - 5 PM</p>
                </div>
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