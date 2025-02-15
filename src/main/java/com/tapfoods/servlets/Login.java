
package com.tapfoods.servlets;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.impl.UserDaoImpl;
import com.dao.model.User;

@WebServlet("/Login")
public class Login extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.fetchByEmail(email);

        if (user != null && email.equals(user.getEmail())) {
            if (password.equals(user.getPassword())) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                Cookie cookie = new Cookie("email", email);
                cookie.setMaxAge(60 * 60 * 24); // 1 day
                resp.addCookie(cookie);

                RequestDispatcher dispatcher = req.getRequestDispatcher("GetRestaurants");
                dispatcher.forward(req, resp);
            } else {
                resp.sendRedirect("PasswordMismatch.html");
            }
        } else {
            resp.sendRedirect("EmailIdNotFound.html");
        }
    }
}
