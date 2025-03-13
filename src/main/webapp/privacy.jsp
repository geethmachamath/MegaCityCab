<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - Mega City Cabs</title>
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
        .privacy-container { background: var(--white); border-radius: 15px; padding: 50px; box-shadow: var(--shadow); }
        .privacy-title { font-size: 2.5rem; font-weight: 700; color: var(--dark-gray); margin-bottom: 30px; text-align: center; }
        .privacy-section { margin-bottom: 40px; }
        .privacy-section h3 { font-size: 1.8rem; font-weight: 600; color: var(--primary-orange); margin-bottom: 20px; }
        .privacy-section p { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 15px; }
        .privacy-section ul { list-style: none; padding-left: 20px; }
        .privacy-section ul li { font-size: 1.1rem; color: var(--dark-gray); margin-bottom: 10px; position: relative; }
        .privacy-section ul li::before { content: '\f058'; font-family: 'Font Awesome 6 Free'; font-weight: 900; color: var(--primary-orange); margin-right: 10px; }
        footer { background: var(--black); color: var(--white); padding: 40px 20px; margin-top: auto; }
        .footer-content { max-width: 1300px; margin: 0 auto; text-align: center; }
        .footer-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 25px; flex-wrap: wrap; }
        .footer-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 5px 10px; transition: all 0.3s ease; }
        .footer-links a:hover { color: var(--primary-orange); }
        .copyright { font-size: 0.9rem; opacity: 0.8; }
        @media (max-width: 768px) {
            .navbar { flex-direction: column; padding: 20px; gap: 20px; }
            .main-content { padding: 40px 20px; }
            .privacy-container { padding: 30px; }
            .privacy-title { font-size: 2rem; }
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
        <div class="privacy-container">
            <h2 class="privacy-title">Privacy Policy</h2>
            <div class="privacy-section">
                <h3>1. Information We Collect</h3>
                <p>We collect the following types of information to provide and improve our services:</p>
                <ul>
                    <li><strong>Personal Data:</strong> Name, email address, phone number, and billing address provided during registration or booking.</li>
                    <li><strong>Usage Data:</strong> Information about how you interact with our website, such as pages visited and booking history.</li>
                    <li><strong>Location Data:</strong> Pickup and drop-off locations to facilitate your rides.</li>
                </ul>
            </div>
            <div class="privacy-section">
                <h3>2. How We Use Your Information</h3>
                <p>Your data is used for the following purposes:</p>
                <ul>
                    <li>To process and manage your bookings efficiently.</li>
                    <li>To communicate with you regarding ride confirmations, updates, or support queries.</li>
                    <li>To enhance our services through analytics and user feedback.</li>
                    <li>To comply with legal obligations, such as tax reporting.</li>
                </ul>
                <p>We do not sell or rent your personal information to third parties.</p>
            </div>
            <div class="privacy-section">
                <h3>3. Data Security</h3>
                <p>We prioritize the security of your information:</p>
                <ul>
                    <li>We use SSL encryption for all data transmissions.</li>
                    <li>Access to your data is restricted to authorized personnel only.</li>
                    <li>Regular security audits are conducted to identify and mitigate risks.</li>
                </ul>
                <p>However, no system is entirely risk-free, and we cannot guarantee absolute security.</p>
            </div>
            <div class="privacy-section">
                <h3>4. Your Rights</h3>
                <p>You have the following rights regarding your data:</p>
                <ul>
                    <li><strong>Access:</strong> Request a copy of the data we hold about you.</li>
                    <li><strong>Correction:</strong> Update inaccurate or incomplete information.</li>
                    <li><strong>Deletion:</strong> Request removal of your data, subject to legal retention requirements.</li>
                </ul>
                <p>Contact us at <a href="mailto:support@megacitycabs.com">support@megacitycabs.com</a> to exercise these rights.</p>
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