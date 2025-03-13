<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Mega City Cabs</title>
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
        .contact-container { background: var(--white); border-radius: 15px; padding: 50px; box-shadow: var(--shadow); }
        .contact-title { font-size: 2.5rem; font-weight: 700; color: var(--dark-gray); margin-bottom: 30px; text-align: center; }
        .contact-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 40px; }
        .contact-card { background: var(--medium-gray); border-radius: 15px; padding: 30px; text-align: center; transition: all 0.3s ease; }
        .contact-card:hover { transform: translateY(-10px); background: var(--white); box-shadow: var(--shadow); }
        .contact-icon { color: var(--primary-orange); font-size: 2.5rem; margin-bottom: 20px; }
        .contact-info { font-size: 1.1rem; color: var(--dark-gray); }
        .contact-info a { color: var(--primary-orange); text-decoration: none; transition: all 0.3s ease; }
        .contact-info a:hover { color: var(--dark-orange); text-decoration: underline; }
        footer { background: var(--black); color: var(--white); padding: 40px 20px; margin-top: auto; }
        .footer-content { max-width: 1300px; margin: 0 auto; text-align: center; }
        .footer-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 25px; flex-wrap: wrap; }
        .footer-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 5px 10px; transition: all 0.3s ease; }
        .footer-links a:hover { color: var(--primary-orange); }
        .copyright { font-size: 0.9rem; opacity: 0.8; }
        @media (max-width: 768px) {
            .navbar { flex-direction: column; padding: 20px; gap: 20px; }
            .main-content { padding: 40px 20px; }
            .contact-container { padding: 30px; }
            .contact-title { font-size: 2rem; }
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