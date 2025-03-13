<%@ page import="java.sql.*, com.login.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
try {
    con = DBConnection.getConnection();
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM cabs");
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Vehicle - Mega City Cabs</title>
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
            background: url("images/sss.png") repeat-y center top;
            background-size: contain; /* Adjusts image size to fit naturally */            
        }

        /* Booking Container */
        .booking-container {
            background: var(--white);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            border-left: 6px solid var(--primary-teal);
            max-width: 500px;
            margin: 0 auto;
        }

        .booking-title {
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

        .form-input, .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--soft-gray);
            background: var(--white);
            color: var(--dark-gray);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-select:focus {
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

        .error-message {
            background: rgba(255, 0, 0, 0.1);
            color: #d32f2f;
            text-align: center;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .distance-link {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .distance-link:hover {
            color: var(--dark-teal);
            text-decoration: underline;
        }

        /* Popup Styles */
        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 2000;
            justify-content: center;
            align-items: center;
        }

        .popup-content {
            position: relative;
            max-width: 90%;
            max-height: 90vh;
            overflow: auto;
        }

        .popup-image {
            width: 100%;
            height: auto;
            border-radius: 10px;
            transition: transform 0.3s ease;
        }

        

        .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            color: var(--white);
            font-size: 2rem;
            cursor: pointer;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .close-btn:hover {
            background: rgba(0, 0, 0, 0.8);
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

            .booking-container {
                padding: 25px;
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

    <!-- Main Content -->
    <div class="main-content">
        <div class="booking-container">
            <h2 class="booking-title">Book a Vehicle</h2>

            <% if (request.getParameter("error") != null) { 
                String error = request.getParameter("error");
            %>
                <div class="error-message">
                    <% if (error.equals("connection")) { %>
                        Booking Failed! Database connection error. Please try again later.
                    <% } else if (error.equals("insert")) { %>
                        Booking Failed! Could not save your booking. Please try again.
                    <% } else { %>
                        Booking Failed! Error: <%= error %> Please try again.
                    <% } %>
                </div>
            <% } %>

            <form action="BookingServlet" method="post">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" class="form-input" required placeholder="Enter your name">
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-input" required placeholder="Enter your email">
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" name="phone" class="form-input" required placeholder="Enter your phone number">
                </div>

                <div class="form-group">
                    <label for="pickup">Pickup Location</label>
                    <input type="text" id="pickup" name="pickup" class="form-input" required placeholder="Enter pickup location">
                </div>

                <div class="form-group">
                    <label for="dropLocation">Drop Location</label>
                    <input type="text" id="dropLocation" name="dropLocation" class="form-input" required placeholder="Enter drop location">
                </div>

                <div class="form-group">
                    <label for="kms">Kms</label>
                    <input type="number" id="kms" name="kms" min="1" class="form-input" required placeholder="Enter distance in kms">
                </div>

                <div class="form-group">
                    <a href="#" class="distance-link" onclick="showPopup()">View distances between cities</a>
                </div>

                <div class="form-group">
                    <label for="cab_id">Choose a Cab</label>
                    <select id="cab_id" name="cab_id" class="form-select" required>
                        <% if (rs != null) { 
                            while (rs.next()) { %>
                                <option value="<%= rs.getInt("id") %>"><%= rs.getString("model") %></option>
                            <% } 
                        } else { %>
                            <option value="">No cabs available</option>
                        <% } %>
                    </select>
                </div>

                <button type="submit" class="submit-btn">Proceed to Bill</button>
            </form>
        </div>
    </div>

    <!-- Popup -->
    <div id="imagePopup" class="popup">
        <div class="popup-content">
            <span class="close-btn" onclick="hidePopup()">&times;</span>
            <img src="images/bg.png" alt="Distance Map" class="popup-image">
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

    <script>
        function showPopup() {
            document.getElementById("imagePopup").style.display = "flex";
        }

        function hidePopup() {
            document.getElementById("imagePopup").style.display = "none";
        }

        // Close popup when clicking outside the image
        document.getElementById("imagePopup").addEventListener("click", function(e) {
            if (e.target === this) {
                hidePopup();
            }
        });
    </script>

    <% 
    // Clean up database resources
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (con != null) con.close();
    %>
</body>
</html>