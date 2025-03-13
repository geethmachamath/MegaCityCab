<%@ page import="java.sql.*, com.login.util.DBConnection, com.login.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History - Mega City Cabs</title>
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

        /* History Container */
        .history-container {
            background: var(--white);
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow);
            border-left: 6px solid var(--primary-teal);
        }

        .history-title {
            color: var(--dark-gray);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: var(--white);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--soft-gray);
        }

        th {
            background: var(--primary-teal);
            color: var(--white);
            font-weight: 600;
        }

        tr:hover {
            background-color: var(--soft-gray);
        }

        .status-confirmed {
            color: #2e7d32;
            font-weight: 600;
        }

        .status-pending {
            color: var(--secondary-teal);
            font-weight: 600;
        }

        .no-bookings {
            margin-top: 20px;
            padding: 15px 20px;
            background: var(--white);
            border-left: 6px solid var(--soft-gray);
            border-radius: 10px;
            color: var(--dark-gray);
        }

        .no-bookings a {
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .no-bookings a:hover {
            color: var(--dark-teal);
            text-decoration: underline;
        }

        .error-message {
            background: rgba(255, 0, 0, 0.1);
            color: #d32f2f;
            text-align: center;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: var(--primary-teal);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link:hover {
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

            .history-container {
                padding: 25px;
            }

            table {
                font-size: 0.9rem;
            }

            th, td {
                padding: 10px;
            }
        }

        @media (max-width: 480px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
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
        <div class="history-container">
            <h2 class="history-title">Your Booking History</h2>
            
            <%
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            boolean hasBookings = false;
            
            try {
                con = DBConnection.getConnection();
                
                String query = "SELECT b.*, c.model AS cab_model FROM bookings b " +
                              "JOIN cabs c ON b.cab_id = c.id " +
                              "WHERE b.email = ? " +
                              "ORDER BY b.id DESC";
                
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, user.getEmail());
                rs = pstmt.executeQuery();
                
                if (rs.next()) {
                    hasBookings = true;
            %>
            
            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>Cab Model</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Distance (km)</th>
                    <th>Status</th>
                    <th>Amount</th>
                </tr>
                
                <%
                    do {
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("cab_model") %></td>
                        <td><%= rs.getString("pickup") %></td>
                        <td><%= rs.getString("dropLocation") %></td>
                        <td><%= rs.getInt("kms") %></td>
                        <td class="<%= rs.getString("status").equals("confirmed") ? "status-confirmed" : "status-pending" %>">
                            <%= rs.getString("status") %>
                        </td>
                        <td>
                            <% if (rs.getObject("totalAmount") != null) { %>
                                LKR <%= String.format("%.2f", rs.getDouble("totalAmount")) %>
                            <% } else { %>
                                Pending
                            <% } %>
                        </td>
                    </tr>
                <%
                    } while (rs.next());
                %>
            </table>
            
            <%
                } else {
                    hasBookings = false;
                }
                
                if (!hasBookings) {
            %>
                <div class="no-bookings">
                    <p>You haven't made any bookings yet.</p>
                    <p>Click <a href="bookVehicle.jsp">here</a> to book a vehicle now.</p>
                </div>
            <%
                }
            } catch (Exception e) {
            %>
                <div class="error-message">
                    Error retrieving booking history: <%= e.getMessage() %>
                </div>
            <%
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            %>
            
            <a href="userDashboard.jsp" class="back-link">Back to Dashboard</a>
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