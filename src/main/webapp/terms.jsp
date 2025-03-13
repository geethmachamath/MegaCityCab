<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms of Service - Mega City Cabs</title>
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
        .terms-container { background: var(--white); border-radius: 15px; padding: 50px; box-shadow: var(--shadow); }
        .terms-title { font-size: 2.5rem; font-weight: 700; color: var(--dark-gray); margin-bottom: 30px; text-align: center; }
        .terms-section { margin-bottom: 40px; }
        .terms-section h3 { font-size: 1.8rem; font-weight: 600; color: var(--primary-orange); margin-bottom: 20px; }
        .terms-section p { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 15px; }
        .terms-section ul { list-style: none; padding-left: 20px; }
        .terms-section ul li { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 10px; position: relative; }
        .terms-section ul li::before { content: '\f058'; font-family: 'Font Awesome 6 Free'; font-weight: 900; color: var(--primary-orange); margin-right: 10px; }
        footer { background: var(--black); color: var(--white); padding: 40px 20px; margin-top: auto; }
        .footer-content { max-width: 1300px; margin: 0 auto; text-align: center; }
        .footer-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 25px; flex-wrap: wrap; }
        .footer-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 5px 10px; transition: all 0.3s ease; }
        .footer-links a:hover { color: var(--primary-orange); }
        .copyright { font-size: 0.9rem; opacity: 0.8; }
        @media (max-width: 768px) {
            .navbar { flex-direction: column; padding: 20px; gap: 20px; }
            .main-content { padding: 40px 20px; }
            .terms-container { padding: 30px; }
            .terms-title { font-size: 2rem; }
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
        <div class="terms-container">
            <h2 class="terms-title">Terms of Service</h2>
            <div class="terms-section">
                <h3>1. Acceptance of Terms</h3>
                <p>By accessing or using Mega City Cabs’ services, you agree to be bound by these Terms of Service. If you do not agree, please refrain from using our platform.</p>
            </div>
            <div class="terms-section">
                <h3>2. Booking and Cancellation</h3>
                <p>Our booking policies ensure a smooth experience:</p>
                <ul>
                    <li>Bookings must be made through our website and paid in full at confirmation.</li>
                    <li>Cancellations made 24 hours prior to the scheduled ride are fully refundable.</li>
                    <li>Cancellations within 24 hours incur a 50% fee; no-shows are non-refundable.</li>
                    <li>We reserve the right to cancel bookings due to unforeseen circumstances, with full refunds provided.</li>
                </ul>
            </div>
            <div class="terms-section">
                <h3>3. User Responsibilities</h3>
                <p>As a user, you agree to:</p>
                <ul>
                    <li>Provide accurate information during registration and booking.</li>
                    <li>Use our services for lawful purposes only.</li>
                    <li>Respect our drivers and maintain vehicle cleanliness.</li>
                    <li>Pay all applicable fees promptly.</li>
                </ul>
            </div>
            <div class="terms-section">
                <h3>4. Limitation of Liability</h3>
                <p>Mega City Cabs is not responsible for:</p>
                <ul>
                    <li>Delays or damages due to traffic, weather, or other uncontrollable events.</li>
                    <li>Loss of personal belongings during rides; please check vehicles before exiting.</li>
                    <li>Indirect or consequential damages arising from service use.</li>
                </ul>
                <p>Our liability is limited to the amount paid for the specific ride in question.</p>
            </div>
            <div class="terms-section">
                <h3>5. Termination</h3>
                <p>We may terminate or suspend your account if you:</p>
                <ul>
                    <li>Violate these terms or engage in fraudulent activity.</li>
                    <li>Misuse our services or harm our reputation.</li>
                </ul>
                <p>You may terminate your account at any time by contacting support.</p>
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