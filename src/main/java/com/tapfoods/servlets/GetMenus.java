package com.tapfoods.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.impl.MenuDaoImpl;
import com.dao.impl.RestaurantDaoImpl;
import com.dao.model.Restaurant;

@WebServlet("/Menu")
public class GetMenus extends HttpServlet {

    private static final String MENU_VIEW = "Menu.jsp";
    private static final String ERROR_VIEW = "ErrorPage.jsp";
    private static final Logger LOGGER = Logger.getLogger(GetMenus.class.getName());

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String attribute = req.getParameter("restaurantId");
            if (attribute == null || attribute.isEmpty()) {
                throw new IllegalArgumentException("Invalid restaurant ID.");
            }
            int id = Integer.parseInt(attribute);
            RestaurantDaoImpl rdi = new RestaurantDaoImpl();
            Restaurant rest = rdi.fetchOne(id);
            req.setAttribute("restaurantName",rest.getRestaurantName() );
            req.setAttribute("rating", rest.getRating());
            req.setAttribute("priceForTwo", 450);
            req.setAttribute("ratingCount", 96);
            req.setAttribute("cuisine", rest.getCuisineType());
            req.setAttribute("location", rest.getAddress());
            req.setAttribute("deliveryTime", rest.getDeliveryTime());

            MenuDaoImpl mdi = new MenuDaoImpl();
            ArrayList<com.dao.model.Menu> menu = mdi.fetchMenuByRestaurantId(id);

            if (menu != null && !menu.isEmpty()) {
                req.setAttribute("menuList", menu);
                RequestDispatcher rd = req.getRequestDispatcher(MENU_VIEW);
                rd.forward(req, resp);
            } else {
                req.setAttribute("errorMessage", "No menu found for the selected restaurant.");
                RequestDispatcher rd = req.getRequestDispatcher(ERROR_VIEW);
                rd.forward(req, resp);
            }
        } catch (NumberFormatException e) {
            LOGGER.severe("Invalid restaurant ID format: " + e.getMessage());
            req.setAttribute("errorMessage", "Invalid restaurant ID format.");
            RequestDispatcher rd = req.getRequestDispatcher(ERROR_VIEW);
            rd.forward(req, resp);
        } catch (Exception e) {
            LOGGER.severe("Error fetching menu: " + e.getMessage());
            req.setAttribute("errorMessage", "An unexpected error occurred.");
            RequestDispatcher rd = req.getRequestDispatcher(ERROR_VIEW);
            rd.forward(req, resp);
        }
    }
}

