package com.login.servlet;

import com.login.model.Employee;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateAdminServlet")
public class UpdateAdminServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/your_database_name";
    private static final String DB_USER = "your_username";
    private static final String DB_PASSWORD = "your_password";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Employee admin = (Employee) session.getAttribute("employee");

        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Validation
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            response.sendRedirect("adminDetails.jsp?error=emptyFields");
            return;
        }

        if (name.length() > 100) {
            response.sendRedirect("adminDetails.jsp?error=invalidNameLength");
            return;
        }

        // Check if there are changes
        if (name.equals(admin.getName())) {
            response.sendRedirect("adminDetails.jsp?error=noUpdate");
            return;
        }

        // Update the database
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, UB_USER, DB_PASSWORD);

            String sql = "UPDATE employees SET name = ? WHERE email = ? AND type = 'admin'";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                // Update session object
                admin.setName(name);
                session.setAttribute("employee", admin);
                response.sendRedirect("adminDetails.jsp?success=true");
            } else {
                response.sendRedirect("adminDetails.jsp?error=databaseError");
            }

        } catch (ClassNotFoundException e) {
            response.sendRedirect("adminDetails.jsp?error=driverNotFound");
        } catch (SQLException e) {
            response.sendRedirect("adminDetails.jsp?error=databaseError");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}