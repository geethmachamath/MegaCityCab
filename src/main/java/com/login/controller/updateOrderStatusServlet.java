package com.login.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.dao.BookingDAO;
import com.login.model.Employee;

public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        System.out.println("UpdateOrderStatusServlet: Initializing servlet");
        bookingDAO = new BookingDAO();
        System.out.println("UpdateOrderStatusServlet: Servlet initialized successfully");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("UpdateOrderStatusServlet: Received POST request");
        System.out.println("UpdateOrderStatusServlet: Request URL: " + request.getRequestURL());
        System.out.println("UpdateOrderStatusServlet: Request URI: " + request.getRequestURI());
        System.out.println("UpdateOrderStatusServlet: Context Path: " + request.getContextPath());

        // Log all request parameters
        System.out.println("UpdateOrderStatusServlet: Request parameters:");
        request.getParameterMap().forEach((key, value) -> 
            System.out.println("  " + key + ": " + String.join(", ", value)));

        // Get the session
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("UpdateOrderStatusServlet: Session is null, redirecting to login.jsp");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check if the driver is logged in
        Employee driver = (Employee) session.getAttribute("employee");
        if (driver == null) {
            System.out.println("UpdateOrderStatusServlet: Driver not found in session, redirecting to login.jsp");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("UpdateOrderStatusServlet: Session driver: email=" + driver.getEmail() + ", type=" + driver.getType());

        if (!"driver".equals(driver.getType())) {
            System.out.println("UpdateOrderStatusServlet: User is not a driver (type: " + driver.getType() + "), redirecting to login.jsp");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        System.out.println("UpdateOrderStatusServlet: Driver email verified: " + driver.getEmail());

        // Get parameters from the form
        String bookingIdParam = request.getParameter("bookingId");
        System.out.println("UpdateOrderStatusServlet: bookingId parameter: " + bookingIdParam);
        if (bookingIdParam == null || bookingIdParam.trim().isEmpty()) {
            System.out.println("UpdateOrderStatusServlet: bookingId is null or empty");
            session.setAttribute("errorMessage", "Booking ID is missing.");
            System.out.println("UpdateOrderStatusServlet: Redirecting to ViewOrdersServlet due to missing bookingId");
            response.sendRedirect(request.getContextPath() + "/ViewOrdersServlet");
            return;
        }

        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdParam);
            System.out.println("UpdateOrderStatusServlet: Parsed Booking ID: " + bookingId);
        } catch (NumberFormatException e) {
            System.out.println("UpdateOrderStatusServlet: Invalid booking ID format: " + bookingIdParam);
            session.setAttribute("errorMessage", "Invalid booking ID format.");
            System.out.println("UpdateOrderStatusServlet: Redirecting to ViewOrdersServlet due to invalid bookingId");
            response.sendRedirect(request.getContextPath() + "/ViewOrdersServlet");
            return;
        }

        String status = request.getParameter("status");
        System.out.println("UpdateOrderStatusServlet: Received status: " + status);
        if (status == null || status.trim().isEmpty()) {
            System.out.println("UpdateOrderStatusServlet: Status is null or empty");
            session.setAttribute("errorMessage", "Status is missing.");
            System.out.println("UpdateOrderStatusServlet: Redirecting to ViewOrdersServlet due to missing status");
            response.sendRedirect(request.getContextPath() + "/ViewOrdersServlet");
            return;
        }

        // Convert status to lowercase for consistency with the database
        status = status.toLowerCase();
        System.out.println("UpdateOrderStatusServlet: Converted status to lowercase: " + status);

        // Validate the status value
        if (!status.equals("pending") && !status.equals("completed") && !status.equals("cancelled")) {
            System.out.println("UpdateOrderStatusServlet: Invalid status value: " + status);
            session.setAttribute("errorMessage", "Invalid status value. Must be 'pending', 'completed', or 'cancelled'.");
            System.out.println("UpdateOrderStatusServlet: Redirecting to ViewOrdersServlet due to invalid status");
            response.sendRedirect(request.getContextPath() + "/ViewOrdersServlet");
            return;
        }

        // Update the booking status
        boolean updated = false;
        try {
            System.out.println("UpdateOrderStatusServlet: Calling BookingDAO.updateBookingStatus with bookingId=" + bookingId + ", driverEmail=" + driver.getEmail() + ", status=" + status);
            updated = bookingDAO.updateBookingStatus(bookingId, driver.getEmail(), status);
            System.out.println("UpdateOrderStatusServlet: Update result: " + (updated ? "Success" : "Failure"));
            if (updated) {
                session.setAttribute("successMessage", "Booking status updated successfully.");
                System.out.println("UpdateOrderStatusServlet: Set successMessage in session");
            } else {
                session.setAttribute("errorMessage", "Failed to update booking status. It may not belong to you or the booking does not exist.");
                System.out.println("UpdateOrderStatusServlet: Set errorMessage in session (update failed)");
            }
        } catch (Exception e) {
            System.out.println("UpdateOrderStatusServlet: Exception during update: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error updating booking status: " + e.getMessage());
            System.out.println("UpdateOrderStatusServlet: Set errorMessage in session due to exception");
        }

        // Redirect to ViewOrdersServlet
        if (!response.isCommitted()) {
            String redirectUrl = request.getContextPath() + "/ViewOrdersServlet";
            System.out.println("UpdateOrderStatusServlet: Redirecting to " + redirectUrl);
            response.sendRedirect(redirectUrl);
        } else {
            System.out.println("UpdateOrderStatusServlet: Response already committed, cannot redirect");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("UpdateOrderStatusServlet: Received GET request (not supported)");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "This endpoint only supports POST requests.");
    }
}