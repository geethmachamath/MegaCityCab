package com.login.controller;

import com.login.dao.UserDAO;
import com.login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");

        if (name == null || address == null || nic == null || name.isEmpty() || address.isEmpty() || nic.isEmpty()) {
            response.sendRedirect("myDetails.jsp?error=emptyFields");
            return;
        }

        // **UPDATE USER OBJECT**
        user.setName(name);
        user.setAddress(address);
        user.setNic(nic);

        // **UPDATE DATABASE**
        UserDAO userDAO = new UserDAO();
        boolean updated = userDAO.updateUser(user);

        if (updated) {
            // **UPDATE SESSION WITH NEW USER DATA**
            session.setAttribute("user", user);
            response.sendRedirect("myDetails.jsp?success=true");
        } else {
            response.sendRedirect("myDetails.jsp?error=updateFailed");
        }
    }
}
