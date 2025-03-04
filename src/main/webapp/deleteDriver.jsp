<%@ page import="com.login.model.Employee" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
Employee admin = (Employee) session.getAttribute("employee");
if (admin == null || !"admin".equals(admin.getType())) {
    response.sendRedirect("login.jsp");
    return;
}

String dbURL = "jdbc:mysql://localhost:3306/login_system";
String dbUser = "root";
String dbPassword = "1234";

String id = request.getParameter("id");
if (id != null) {
    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM employees WHERE id = ? AND type = 'driver'");
        stmt.setInt(1, Integer.parseInt(id));
        stmt.executeUpdate();
        response.sendRedirect("driverDetails.jsp?success=Driver deleted successfully");
    } catch (SQLException e) {
        response.sendRedirect("driverDetails.jsp?error=Error deleting driver: " + e.getMessage());
    }
} else {
    response.sendRedirect("driverDetails.jsp?error=Invalid driver ID");
}
%>