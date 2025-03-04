package com.login.controller;

import com.login.dao.UserDAO;
import com.login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User newUser = new User(name, address, nic, email, password);

        UserDAO userDAO = new UserDAO();
        boolean registered = userDAO.registerUser(newUser);

        if (registered) {
            response.sendRedirect("login.jsp?msg=success");
        } else {
            response.sendRedirect("register.jsp?msg=error");
        }
    }
}
