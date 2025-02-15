package com.tapfoods.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.impl.UserDaoImpl;
import com.dao.model.User;

@WebServlet("/Registration")
public class Registration extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Retrieve password and confirm password
        String password = req.getParameter("password");
        String cPassword = req.getParameter("cpassword");

        // Check if passwords match
        if (password.equals(cPassword)) {
            // Retrieve other form fields
            String username = req.getParameter("username");
            String address = req.getParameter("address");
            String email = req.getParameter("email");

            UserDaoImpl userDaoImpl = new UserDaoImpl();

            // Check if the email already exists in the database
            User existingUser = userDaoImpl.fetchByEmail(email);
            if (existingUser != null) {
                // Email already exists, redirect to an error page
                resp.sendRedirect("RegistrationUnsuccessful.html");
            } else {
                // Create a new user object
                User newUser = new User(username, password, email, address);

                // Insert the new user into the database
                int num = userDaoImpl.insert(newUser);
                if (num == 1) {
                    // Registration successful, redirect to success page
                    resp.sendRedirect("Login.html");
                } else {
                    // Registration unsuccessful due to an error, redirect to failure page
                    resp.sendRedirect("RegistrationUnsuccessful.html");
                }
            }
        } else {
            // Passwords do not match, redirect to an error page
            resp.sendRedirect("PasswordMismatch.html");
        }
    }
}
