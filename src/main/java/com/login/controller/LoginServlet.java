package com.login.controller;

import com.login.dao.EmployeeDAO;
import com.login.dao.UserDAO;
import com.login.model.Employee;
import com.login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();

        User user = userDAO.validateUser(email, password);
        Employee employee = employeeDAO.validateEmployee(email, password);

        HttpSession session = request.getSession();

        if (user != null) {
            session.setAttribute("user", user);
            response.sendRedirect("userDashboard.jsp");
        } else if (employee != null) {
            session.setAttribute("employee", employee);
            if ("admin".equals(employee.getType())) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("driver".equals(employee.getType())) {
                response.sendRedirect("driverDashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}
