package com.tapfoods.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.impl.MenuDaoImpl;
import com.dao.interfaces.MenuDAO;
import com.dao.model.CartCreator;
import com.dao.model.CartItem;
import com.dao.model.Menu;

@WebServlet("/Cart")
public class CartServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartCreator cart = (CartCreator) session.getAttribute("cart");
        if (cart == null) {
            cart = new CartCreator();
            session.setAttribute("cart", cart);
        }
        
        String action = req.getParameter("action");
        MenuDAO menuDao = new MenuDaoImpl();
        
        try {
        	if ("add".equals(action)) {
        	    int itemId = Integer.parseInt(req.getParameter("itemId"));
        	    int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        	    
        	    if (cart.getRestaurantId() != 0 && cart.getRestaurantId() != restaurantId) {
        	        cart.clear(); // Clear cart if switching restaurants
        	    }
        	    cart.setRestaurantId(restaurantId); // Set the restaurant context

        	    Menu menuItem = menuDao.fetchOne(itemId);
        	    if (menuItem != null) {
        	        CartItem existingItem = cart.getAllItems().get(itemId);
        	        if (existingItem != null) {
        	            existingItem.setQuantity(existingItem.getQuantity() + 1);
        	        } else {
        	            cart.addCartItem(new CartItem(
        	                menuItem.getMenuId(),
        	                restaurantId,
        	                menuItem.getName(),
        	                1,
        	                menuItem.getPrice()
        	            ));
        	        }
        	        session.setAttribute("cart", cart);
        	        resp.sendRedirect("Cart.jsp?restaurantId=" + restaurantId); // Redirect with restaurantId
        	    }
        	} else if ("update".equals(action)) {
        	    int itemId = Integer.parseInt(req.getParameter("itemId"));
        	    int quantity = Integer.parseInt(req.getParameter("quantity"));
        	    int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        	    
        	    if (cart.getRestaurantId() == restaurantId) { // Ensure same restaurant context
        	        cart.updateCartItem(itemId, quantity);
        	    }
        	    session.setAttribute("cart", cart);
        	    resp.sendRedirect("Cart.jsp?restaurantId=" + restaurantId); // Redirect with restaurantId
        	} else if ("remove".equals(action)) {
        	    int itemId = Integer.parseInt(req.getParameter("itemId"));
        	    int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        	    if (cart.getRestaurantId() == restaurantId) { // Ensure same restaurant context
        	        cart.removeItem(itemId);
        	    }
        	    session.setAttribute("cart", cart);
        	    resp.sendRedirect("Cart.jsp?restaurantId=" + restaurantId); // Redirect with restaurantId
        	}

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request.");
        }
    }


}



















//if ("add".equals(action)) {
//    int itemId = Integer.parseInt(req.getParameter("itemId"));
//    int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
//    Menu menuItem = menuDao.fetchOne(itemId);
//
//    if (menuItem != null) {
//        CartItem existingItem = cart.getAllItems().get(itemId);
//        if (existingItem != null) {
//            existingItem.setQuantity(existingItem.getQuantity() + 1);
//        } else {
//            cart.addCartItem(new CartItem(
//                menuItem.getMenuId(),
//                restaurantId,
//                menuItem.getName(),
//                1,
//                menuItem.getPrice()
//            ));
//        }
//        session.setAttribute("cart", cart);
//        resp.sendRedirect("Cart.jsp");
//    } 
//} else if ("update".equals(action)) {
//    int itemId = Integer.parseInt(req.getParameter("itemId"));
//    int quantity = Integer.parseInt(req.getParameter("quantity"));
//    cart.updateCartItem(itemId, quantity);
//    session.setAttribute("cart", cart);
//    resp.sendRedirect("Cart.jsp");
//} else if ("remove".equals(action)) {
//    int itemId = Integer.parseInt(req.getParameter("itemId"));
//    cart.removeItem(itemId);
//    session.setAttribute("cart", cart);
//    resp.sendRedirect("Cart.jsp");
//}

