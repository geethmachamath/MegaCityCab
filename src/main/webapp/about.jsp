<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Mega City Cabs</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        :root { 
            --primary-orange: #FF8400; 
            --dark-orange: #FF9000; 
            --light-gray: #F5F7FA; 
            --medium-gray: #ECEFF1; 
            --dark-gray: #263238; 
            --white: #FFFFFF; 
            --black: #1A1A1A; 
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1); 
        }
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
        .about-container { background: var(--white); border-radius: 15px; padding: 50px; box-shadow: var(--shadow); }
        .about-title { font-size: 2.5rem; font-weight: 700; color: var(--dark-gray); margin-bottom: 30px; text-align: center; }
        .about-subtitle { font-size: 1.2rem; color: var(--dark-gray); text-align: center; margin-bottom: 40px; opacity: 0.8; }
        .about-section { margin-bottom: 40px; }
        .about-section h3 { font-size: 1.8rem; font-weight: 600; color: var(--primary-orange); margin-bottom: 20px; }
        .about-section p { font-size: 1.1rem; color: var(--dark-gray); }
        .team-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 30px; margin-top: 40px; }
        .team-card { background: var(--medium-gray); border-radius: 15px; padding: 25px; text-align: center; transition: all 0.3s ease; }
        .team-card:hover { transform: translateY(-10px); background: var(--white); box-shadow: var(--shadow); }
        .team-card img { width: 100px; height: 100px; border-radius: 50%; margin-bottom: 15px; }
        .team-name { font-size: 1.3rem; font-weight: 600; color: var(--dark-gray); }
        .team-role { font-size: 1rem; color: var(--primary-orange); }
        footer { background: var(--black); color: var(--white); padding: 40px 20px; margin-top: auto; }
        .footer-content { max-width: 1300px; margin: 0 auto; text-align: center; }
        .footer-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 25px; flex-wrap: wrap; }
        .footer-links a { color: var(--white); text-decoration: none; font-weight: 500; padding: 5px 10px; transition: all 0.3s ease; }
        .footer-links a:hover { color: var(--primary-orange); }
        .copyright { font-size: 0.9rem; opacity: 0.8; }
        @media (max-width: 768px) {
            .navbar { flex-direction: column; padding: 20px; gap: 20px; }
            .main-content { padding: 40px 20px; }
            .about-container { padding: 30px; }
            .about-title { font-size: 2rem; }
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
        <div class="about-container">
            <h2 class="about-title">About Mega City Cabs</h2>
            <p class="about-subtitle">Delivering Exceptional Transportation Since 2013</p>
            <div class="about-section">
                <h3>Our Story</h3>
                <p>Mega City Cabs was founded in 2013 with a vision to revolutionize urban transportation. Starting with a small fleet of 10 vehicles in Colombo, we’ve grown to over 200 vehicles serving 10+ cities across Sri Lanka. Our commitment to safety, reliability, and customer satisfaction has made us a trusted name in the industry.</p>
            </div>
            <div class="about-section">
                <h3>Our Mission</h3>
                <p>We aim to provide seamless, comfortable, and eco-friendly transportation solutions. By leveraging modern technology and a customer-centric approach, we ensure every ride is a pleasant experience, whether you're commuting to work or exploring new destinations.</p>
            </div>
            <div class="about-section">
                <h3>Meet Our Team</h3>
                <div class="team-grid">
                    <div class="team-card">
                        <img src="images/team1.jpg" alt="Team Member">
                        <div class="team-name">John Doe</div>
                        <div class="team-role">CEO & Founder</div>
                    </div>
                    <div class="team-card">
                        <img src="images/team2.jpg" alt="Team Member">
                        <div class="team-name">Lily Carter</div>
                        <div class="team-role">Operations Manager</div>
                    </div>
                    <div class="team-card">
                        <img src="images/team3.jpg" alt="Team Member">
                        <div class="team-name">Michael Lee</div>
                        <div class="team-role">Customer Support Lead</div>
                    </div>
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