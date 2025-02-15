<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - TapFoods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="CssFolder/checkout.css">
</head>
<body>
    <div class="container checkout-container">
        <h1 class="main-title">Checkout</h1>
        
        <div class="checkout-grid card">
            <div class="order-summary card-section">
                <h2 class="section-title">Order Summary</h2>
                <% 
                CartCreator cart = (CartCreator) session.getAttribute("cart");
                if (cart != null && !cart.getAllItems().isEmpty()) {
                    double totalAmount = 0;
                    for (CartItem item : cart.getAllItems().values()) {
                        totalAmount += item.getPrice() * item.getQuantity();
                %>
                <div class="cart-item">
                    <span><%= item.getName() %></span>
                    <span>x<%= item.getQuantity() %></span>
                    <span>₹<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
                </div>
                <%
                    }
                %>
                <div class="total">
                    <strong>Total Amount:</strong>
                    <strong>₹<%= String.format("%.2f", totalAmount) %></strong>
                </div>
                <% } else { %>
                <p>Your cart is empty. Please add items to proceed.</p>
                <a href="Menu.jsp" class="btn btn-secondary">Browse Menu</a>
                <% } %>
            </div>

            <% if (cart != null && !cart.getAllItems().isEmpty()) { %>
            <div class="checkout-form card-section">
                <h2 class="section-title">Delivery Address</h2>
                <form id="checkoutForm" action="CheckOutServlet" method="post">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="pincode">Pincode</label>
                        <input type="text" id="pincode" name="pincode" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>

                    <h2 class="section-title">Payment Method</h2>
                    <div class="form-group">
                        <select id="paymentMethod" name="paymentMethod" required>
                            <option value="">Select Payment Method</option>
                            <option value="cod">Cash on Delivery</option>
                            <option value="card">Credit/Debit Card</option>
                            <option value="upi">UPI</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary btn-large">Place Order</button>
                </form>
            </div>
            <% } %>
        </div>
    </div>

    <script>
        document.getElementById('checkoutForm').addEventListener('submit', function(event) {
            event.preventDefault();
            if (this.checkValidity() && document.getElementById('paymentMethod').value) {
                this.submit();
            } else {
                alert('Please fill in all required fields and select a payment method.');
            }
        });
    </script>
</body>
</html>

