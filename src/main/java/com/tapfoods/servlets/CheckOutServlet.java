package com.tapfoods.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.impl.OrdersDaoImpl;
import com.dao.interfaces.OrdersDAO;
import com.dao.model.CartCreator;
import com.dao.model.CartItem;
import com.dao.model.Orders;
import com.dao.model.User;

@WebServlet("/CheckOutServlet")
public class CheckOutServlet extends HttpServlet {
    
    private OrdersDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrdersDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartCreator cart = (CartCreator) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (user != null) {
            if (cart != null && !cart.getAllItems().isEmpty()) {
                Orders order = new Orders();
                String paymentMethod = req.getParameter("paymentMethod");
                if (paymentMethod == null || paymentMethod.isEmpty()) {
                    resp.sendRedirect("checkout.jsp?error=Please+select+a+payment+method");
                    return;
                }

                int restaurantId = cart.getRestaurantId();
                int userId = user.getUserid();
                double totalAmount = 0;
                for (CartItem item : cart.getAllItems().values()) {
                    totalAmount += item.getPrice() * item.getQuantity();
                }

                order.setPaymentMode(paymentMethod);
                order.setRestaurantId(restaurantId);
                order.setUserId(userId);
                order.setStatus("pending");
                order.setTotalAmount((float) totalAmount);
                
                // Insert order into the database
                orderDAO.insert(order);

                // Clear cart and redirect to confirmation
                session.removeAttribute("cart");
                session.setAttribute("order", order);

                resp.sendRedirect("order-confirmation.jsp");
            } else {
                resp.sendRedirect("checkout.jsp?error=Your+cart+is+empty");
            }
        } else {
            resp.sendRedirect("Login.html");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Redirect GET requests to the checkout page
        resp.sendRedirect("checkout.jsp");
    }
}

