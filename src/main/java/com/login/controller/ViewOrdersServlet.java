package com.login.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.dao.BookingDAO;
import com.login.model.Employee;
import com.login.model.Booking;

public class ViewOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        System.out.println("ViewOrdersServlet: Initializing servlet");
        bookingDAO = new BookingDAO();
        System.out.println("ViewOrdersServlet: Servlet initialized successfully");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ViewOrdersServlet: Received GET request");
        System.out.println("ViewOrdersServlet: Request URL: " + request.getRequestURL());
        System.out.println("ViewOrdersServlet: Request URI: " + request.getRequestURI());

        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("ViewOrdersServlet: Session is null, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        Employee driver = (Employee) session.getAttribute("employee");
        if (driver == null) {
            System.out.println("ViewOrdersServlet: Driver not found in session, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        if (!"driver".equals(driver.getType())) {
            System.out.println("ViewOrdersServlet: User is not a driver (type: " + driver.getType() + "), redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("ViewOrdersServlet: Driver email: " + driver.getEmail());
        System.out.println("ViewOrdersServlet: Driver type: " + driver.getType());

        List<Booking> bookings = null;
        try {
            System.out.println("ViewOrdersServlet: Fetching bookings for driver");
            bookings = bookingDAO.getBookingsForDriver(driver.getEmail());
        } catch (Exception e) {
            System.err.println("ViewOrdersServlet: Error fetching bookings for driver: " + driver.getEmail() + ", error: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("ViewOrdersServlet: Total Bookings Found: " + (bookings != null ? bookings.size() : 0));
        if (bookings != null) {
            for (Booking booking : bookings) {
                System.out.println("ViewOrdersServlet: Booking Details:");
                System.out.println("  ID: " + booking.getId());
                System.out.println("  Name: " + booking.getName());
                System.out.println("  Phone: " + booking.getPhone());
                System.out.println("  Pickup: " + booking.getPickup());
                System.out.println("  Drop Location: " + booking.getDropLocation());
                System.out.println("  Status: " + booking.getStatus());
                System.out.println("  Booked Date: " + booking.getBookedDate());
                System.out.println("  ---");
            }
        } else {
            System.out.println("ViewOrdersServlet: No bookings retrieved (bookings list is null)");
        }

        System.out.println("ViewOrdersServlet: Setting bookings attribute and forwarding to viewOrders.jsp");
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("viewOrders.jsp").forward(request, response);
        System.out.println("ViewOrdersServlet: Forwarded to viewOrders.jsp");
    }
}