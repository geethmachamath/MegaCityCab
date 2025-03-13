<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help - Mega City Cabs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Same styles as above */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        :root { --primary-orange: #FF8400; --dark-orange: #FF9000; --light-gray: #F5F7FA; --medium-gray: #ECEFF1; --dark-gray: #263238; --white: #FFFFFF; --black: #1A1A1A; --shadow: 0 8px 32px rgba(0, 0, 0, 0.1); }
        body { min-height: 100vh; display: flex; flex-direction: column; color: var(--dark-gray); background: var(--light-gray); line-height: 1.8; }
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 20px 40px; background: var(--black); color: var(--white); position: sticky; top: 0; z-index: 1000; box-shadow: var(--shadow); }
        .logo { display: flex; align-items: center; gap: 15px; }
        .logo img { height: 50px; transition: transform 0.3s ease; }
        .logo img:hover { transform: rotate(10deg) scale(1.1); }
        .logo span { font-size: 1.6rem; font-weight: 600; letter-spacing: 1px; }
        .nav-links { display: flex; gap: 25px; }
        .nav-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 10px 20px; border-radius: 25px; transition: all 0.3s ease; }
        .nav-links a:hover { background: var(--primary-orange); color: var(--white); }
        .logout-btn { background: var(--primary-orange); color: var(--white); border: none; padding: 12px 40px; border-radius: 25px; cursor: pointer; font-weight: 600; transition: all 0.3s ease; }
        .logout-btn:hover { background: var(--dark-orange); transform: scale(1.05); }
        .main-content { flex: 1; padding: 60px 40px; max-width: 1300px; margin: 0 auto; width: 100%; }
        .help-container { background: var(--white); border-radius: 15px; padding: 50px; box-shadow: var(--shadow); }
        .help-title { font-size: 2.5rem; font-weight: 700; color: var(--dark-gray); margin-bottom: 30px; text-align: center; }
        .help-section { margin-bottom: 40px; }
        .help-section h3 { font-size: 1.8rem; font-weight: 600; color: var(--primary-orange); margin-bottom: 20px; }
        .help-section p { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 15px; }
        .help-section ul { list-style: none; padding-left: 20px; }
        .help-section ul li { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 10px; position: relative; }
        .help-section ul li::before { content: '\f058'; font-family: 'Font Awesome 6 Free'; font-weight: 900; color: var(--primary-orange); margin-right: 10px; }
        footer { background: var(--black); color: var(--white); padding: 40px 20px; margin-top: auto; }
        .footer-content { max-width: 1300px; margin: 0 auto; text-align: center; }
        .footer-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 25px; flex-wrap: wrap; }
        .footer-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 5px 10px; transition: all 0.3s ease; }
        .footer-links a:hover { color: var(--primary-orange); }
        .copyright { font-size: 0.9rem; opacity: 0.8; }
        @media (max-width: 768px) {
            .navbar { flex-direction: column; padding: 20px; gap: 20px; }
            .main-content { padding: 40px 20px; }
            .help-container { padding: 30px; }
            .help-title { font-size: 2rem; }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <img src="images/logo.png" alt="Company Logo">
         </div>
        <div class="nav-links">
            
        </div>
        <form action="logout.jsp" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </nav>

    <div class="main-content">
        <div class="help-container">
            <h2 class="help-title">Help & Usage Guidelines</h2>
            <div class="help-section">
                <h3>Getting Started</h3>
                <p>Welcome to Mega City Cabs! Whether you're a new user or a returning customer, here’s how to navigate our system efficiently:</p>
                <ul>
                    <li>Create an account or log in using your email and password on the login page.</li>
                    <li>Explore the dashboard to access key features like booking a ride or viewing your history.</li>
                    <li>Update your profile details under "My Account" to ensure smooth communication.</li>
                    <li>For first-time users, we recommend reviewing the booking process below.</li>
                </ul>
            </div>
            <div class="help-section">
                <h3>How to Book a Ride</h3>
                <p>Booking a vehicle with us is simple and straightforward:</p>
                <ul>
                    <li>Go to "Book Vehicle" from the navigation menu.</li>
                    <li>Enter your pickup location, drop-off destination, and preferred travel date.</li>
                    <li>Choose from our diverse fleet (e.g., BMW i8, Toyota Prius) based on availability.</li>
                    <li>Provide trip details like distance and confirm your booking.</li>
                    <li>Review the estimated cost, then proceed to payment via our secure gateway.</li>
                </ul>
            </div>
            <div class="help-section">
                <h3>Managing Your Account</h3>
                <p>Keep your account up-to-date for a seamless experience:</p>
                <ul>
                    <li>Visit "My Account" to edit your name, address, or contact details.</li>
                    <li>Check "History" to review past rides, including dates, destinations, and costs.</li>
                    <li>Log out securely using the "Logout" button when done.</li>
                </ul>
            </div>
            <div class="help-section">
                <h3>Common Issues & Solutions</h3>
                <p>If you face any challenges, try these steps:</p>
                <ul>
                    <li><strong>Login Problems:</strong> Verify your email and password; reset if necessary.</li>
                    <li><strong>Booking Errors:</strong> Ensure all fields are completed and your internet connection is stable.</li>
                    <li><strong>Payment Issues:</strong> Confirm your payment method is valid; contact support if issues persist.</li>
                    <li><strong>Need More Help?</strong> Reach out via the "Contact" page or call +94 112 345 678.</li>
                </ul>
            </div>
        </div>
    </div>

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