package com.tapfoods.servlets;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.impl.RestaurantDaoImpl;
import com.dao.model.Restaurant;
import com.dao.model.User;

@WebServlet("/GetRestaurants")
public class GetRestaurants extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RestaurantDaoImpl restaurantDao = new RestaurantDaoImpl();
        ArrayList<Restaurant> restaurants = restaurantDao.fetchAll();

        // Store the restaurant list in the session for reuse
        HttpSession session = req.getSession(true); // Create a session if not present
        session.setAttribute("restaurantList", restaurants);

        // Check if the user is logged in for personalization
        User user = (User) session.getAttribute("user");
        if (user != null) {
            req.setAttribute("username", user.getUsername());
        }

        // Forward to the JSP page
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}













//@WebServlet("/GetRestaurants")
//public class GetRestaurants extends HttpServlet {
//
//    @Override
//    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        HttpSession session = req.getSession(false);
//        if (session != null && session.getAttribute("user") != null) {
//            RestaurantDaoImpl restaurantDao = new RestaurantDaoImpl();
//            ArrayList<Restaurant> restaurants = restaurantDao.fetchAll();
//
//            if (restaurants != null && !restaurants.isEmpty()) {
//                session.setAttribute("restaurantList", restaurants);
//                resp.sendRedirect("AfterLogin.jsp");
//            } else {
//                resp.sendRedirect("NoRestaurantsFound.html");
//            }
//        } else {
//            resp.sendRedirect("Login.html");
//        }
//    }
//}
