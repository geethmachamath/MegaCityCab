<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cabs</title>
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

        /* Login Container */
        .login-container {
            background: var(--white);
            border-radius: 20px;
            padding: 50px;
            width: 100%;
            max-width: 400px;
            box-shadow: var(--shadow);
            margin: 50px auto;
            border-left: 6px solid var(--primary-teal);
        }

        .login-title {
            color: var(--dark-gray);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: var(--dark-gray);
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--soft-gray);
            background: var(--white);
            color: var(--dark-gray);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-teal);
            box-shadow: 0 0 0 3px rgba(255, 132, 0, 0.2);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: var(--primary-teal);
            color: var(--white);
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .submit-btn:hover {
            background: var(--dark-teal);
            transform: scale(1.05);
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: var(--dark-gray);
        }

        .register-link a {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            color: var(--dark-teal);
            text-decoration: underline;
        }

        .error-message {
            background: rgba(255, 0, 0, 0.1);
            color: #d32f2f;
            text-align: center;
            padding: 10px;
            border-radius: 10px;
            margin-top: 20px;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 20px;
                gap: 20px;
            }

            .login-container {
                margin: 20px;
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <img src="images/logo.png" alt="Company Logo">
            
        </div>
        <form action="register.jsp" method="post">
            <button type="submit" class="logout-btn">Register Here</button>
        </form>
         
    </nav>

    <!-- Login Container -->
    <div class="login-container">
        <h2 class="login-title">Welcome Back</h2>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" class="form-input" required placeholder="Enter your email">
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-input" required placeholder="Enter your password">
            </div>
            
            <button type="submit" class="submit-btn">Login</button>
        </form>
        
        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>

        <%-- Display error messages if login fails --%>
        <% if ("invalid".equals(request.getParameter("msg"))) { %>
            <div class="error-message">
                Invalid email or password. Please try again.
            </div>
        <% } %>
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