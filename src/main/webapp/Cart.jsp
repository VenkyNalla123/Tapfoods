<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - TapFoods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="CssFolder/cart.css">
</head>
<body>
    <header>
        <div class="header-container">
            <a href="index.jsp" class="logo">TapFoods</a>
            <nav class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="#offers">Offers</a>
                <a href="#help">Help</a>
                <% User user = (User) session.getAttribute("user");
                if (user != null) { %>
                    <span class="username"><%= user.getUsername() %></span>
                    <a href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
                <% } else { %>
                    <a href="Login.html">Sign In</a>
                    <a href="Registration.html">Sign Up</a>
                <% } %>
            </nav>
        </div>
    </header>

    <div class="container">
        <h1>Your Cart</h1>
        <%
        CartCreator cart = (CartCreator) session.getAttribute("cart");
        if (cart == null || cart.getAllItems().isEmpty()) {
        %>
        <div class="empty-cart">
            <p>Your cart is empty. Let's add some delicious items!</p>
            <a href="index.jsp">Browse Menu</a>
        </div>
        <%
        } else {
            double totalAmount = 0;
            int restaurantId = cart.getRestaurantId();
        %>
        <div class="cart-container">
            <%
            for (Map.Entry<Integer, CartItem> entry : cart.getAllItems().entrySet()) {
                CartItem item = entry.getValue();
                totalAmount += item.getPrice() * item.getQuantity();
            %>
            <div class="cart-item">
                <div class="cart-item-details">
                    <div class="cart-item-name"><%= item.getName() %></div>
                    <div class="cart-item-price">₹<%= String.format("%.2f", item.getPrice()) %> each</div>
                    <div class="cart-item-subtotal">Subtotal: ₹<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></div>
                </div>
                <div class="cart-item-actions">
                    <form action="Cart" class="quantity-control">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= cart.getRestaurantId() %>">
                        <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>">-</button>
                        <span><%= item.getQuantity() %></span>
                        <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>">+</button>
                    </form>
                    <form action="Cart">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </div>
            </div>
            <% 
                } 
            %>
        </div>
        <div class="cart-summary">
            <div class="cart-total">Total Amount: ₹<%= String.format("%.2f", totalAmount) %></div>
            <div class="cart-actions">
                <a href="Menu?restaurantId=<%= restaurantId %>" class="continue-shopping">Add More Items</a>
                <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
            </div>
        </div>
        <% 
            }
        %>
    </div>
    <script>
	document.querySelectorAll('.quantity-control').forEach(form => {
	    form.addEventListener('submit', function(e) {
	        const quantityButton = this.querySelector('button[name="quantity"]');
	        if (parseInt(quantityButton.value, 10) === 0) {
	            const confirmRemoval = confirm('Are you sure you want to remove this item from your cart?');
	            if (!confirmRemoval) {
	                e.preventDefault(); // Prevent form submission if user cancels.
	            }
	        }
	    });
	});
	
	// Add a listener to remove buttons to confirm removal
	document.querySelectorAll('.remove-btn').forEach(button => {
	    button.addEventListener('click', function(e) {
	        const confirmRemoval = confirm('Are you sure you want to remove this item from your cart?');
	        if (!confirmRemoval) {
	            e.preventDefault(); // Prevent form submission if user cancels.
	        }
	    });
	});
</script>
    
</body>
</html>

























<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
<%@ page import="java.util.*,com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - TapFoods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Existing styles here... */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .cart-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .cart-item-details {
            flex-grow: 1;
        }
        .cart-item-name {
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 5px;
        }
        .cart-item-price, .cart-item-subtotal {
            color: #7f8c8d;
            font-size: 14px;
        }
        .cart-item-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #2980b9;
        }
        .remove-btn {
            background-color: #e74c3c;
        }
        .remove-btn:hover {
            background-color: #c0392b;
        }
        .cart-summary {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: right;
        }
        .cart-total {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .cart-actions a {
            text-decoration: none;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .continue-shopping {
            background-color: #2ecc71;
        }
        .continue-shopping:hover {
            background-color: #27ae60;
        }
        .checkout-btn {
            background-color: #e67e22;
        }
        .checkout-btn:hover {
            background-color: #d35400;
        }
        .empty-cart {
            text-align: center;
            padding: 40px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .empty-cart p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .empty-cart a {
            display: inline-block;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .empty-cart a:hover {
            background-color: #2980b9;
        }
        .container {
            font-family: 'Poppins', sans-serif;
            padding: 20px;
        }
        .empty-cart {
            text-align: center;
        }
        .cart-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        .cart-item-details {
            display: flex;
            flex-direction: column;
        }
        .cart-item-actions {
            display: flex;
            gap: 10px;
        }
        .cart-summary {
            margin-top: 20px;
            text-align: right;
        }
        .cart-actions a {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border-radius: 5px;
        }
        .cart-actions a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Cart</h1>
        <%
        CartCreator cart = (CartCreator) session.getAttribute("cart");
        if (cart == null || cart.getAllItems().isEmpty()) {
        %>
        <div class="empty-cart">
            <p>Your cart is empty.</p>
            <a href="index.jsp">Browse Menu</a>
        </div>
        <%
        } else {
            double totalAmount = 0;
            int restaurantId = cart.getRestaurantId(); // Assuming CartCreator has a method to fetch restaurant ID
        %>
        <div class="cart-container">
            <%
            for (Map.Entry<Integer, CartItem> entry : cart.getAllItems().entrySet()) {
                CartItem item = entry.getValue();
                totalAmount += item.getPrice() * item.getQuantity();
            %>
            <div class="cart-item">
                <div class="cart-item-details">
                    <div class="cart-item-name"><%= item.getName() %></div>
                    <div class="cart-item-price">$<%= String.format("%.2f", item.getPrice()) %> each</div>
                    <div class="cart-item-subtotal">Subtotal: $<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></div>
                </div>
                <div class="cart-item-actions">
                    <form action="Cart" class="quantity-control">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= cart.getRestaurantId() %>">
                        <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>">-</button>
                        <span><%= item.getQuantity() %></span>
                        <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>">+</button>
                    </form>
                    <form action="Cart">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </div>
            </div>
            <% 
                } 
            %>
        </div>
        <div class="cart-summary">
            <div class="cart-total">Total Amount: $<%= String.format("%.2f", totalAmount) %></div>
            <div class="cart-actions">
                <a href="Menu?restaurantId=<%= restaurantId %>" class="continue-shopping">Continue Shopping</a>
                <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
            </div>
        </div>
        <% 
            }
        %>
    </div>
    <script>
    document.querySelectorAll('.quantity-control').forEach(form => {
        form.addEventListener('submit', function(e) {
            if (this.querySelector('button[name="quantity"]').value === '0') {
                if (!confirm('Are you sure you want to remove this item from your cart?')) {
                    e.preventDefault();
                }
            }
        });
    });

    document.querySelectorAll('.remove-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to remove this item from your cart?')) {
                e.preventDefault();
            }
        });
    });
    </script>
</body>
</html>

--%>


























<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - TapFoods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .cart-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .cart-item-details {
            flex-grow: 1;
        }
        .cart-item-name {
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 5px;
        }
        .cart-item-price, .cart-item-subtotal {
            color: #7f8c8d;
            font-size: 14px;
        }
        .cart-item-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #2980b9;
        }
        .remove-btn {
            background-color: #e74c3c;
        }
        .remove-btn:hover {
            background-color: #c0392b;
        }
        .cart-summary {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            border-radius: 8px;
            text-align: right;
        }
        .cart-total {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .cart-actions a {
            text-decoration: none;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .continue-shopping {
            background-color: #2ecc71;
        }
        .continue-shopping:hover {
            background-color: #27ae60;
        }
        .checkout-btn {
            background-color: #e67e22;
        }
        .checkout-btn:hover {
            background-color: #d35400;
        }
        .empty-cart {
            text-align: center;
            padding: 40px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .empty-cart p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .empty-cart a {
            display: inline-block;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .empty-cart a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Cart</h1>
        <%
        CartCreator cart = (CartCreator) session.getAttribute("cart");
                    if (cart == null || cart.getAllItems().isEmpty()) {
        %>
        <div class="empty-cart">
            <p>Your cart is empty.</p>
            <a href="index.jsp">Browse Menu</a>
        </div>
        <%
        } else {
                        double totalAmount = 0;
        %>
        <div class="cart-container">
            <%
            for (Map.Entry<Integer, CartItem> entry : cart.getAllItems().entrySet()) {
                                CartItem item = entry.getValue();
                                totalAmount += item.getPrice() * item.getQuantity();
            %>
            <div class="cart-item">
                <div class="cart-item-details">
                    <div class="cart-item-name"><%= item.getName() %></div>
                    <div class="cart-item-price">$<%= String.format("%.2f", item.getPrice()) %> each</div>
                    <div class="cart-item-subtotal">Subtotal: $<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></div>
                </div>
                <div class="cart-item-actions">
                    <form action="Cart" class="quantity-control">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <button type="submit" name="quantity" value="<%= item.getQuantity() - 1 %>">-</button>
                        <span><%= item.getQuantity() %></span>
                        <button type="submit" name="quantity" value="<%= item.getQuantity() + 1 %>">+</button>
                    </form>
                    <form action="Cart">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </div>
            </div>
            <% 
                } 
            %>
        </div>
        <div class="cart-summary">
            <div class="cart-total">Total Amount: $<%= String.format("%.2f", totalAmount) %></div>
            <div class="cart-actions">
                <a href="Menu.jsp" class="continue-shopping">Continue Shopping</a>
                <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
            </div>
        </div>
        <% 
            }
        %>
    </div>
    <script>
        document.querySelectorAll('.quantity-control').forEach(form => {
            form.addEventListener('submit', function(e) {
                if (this.querySelector('button[name="quantity"]').value === '0') {
                    if (!confirm('Are you sure you want to remove this item from your cart?')) {
                        e.preventDefault();
                    }
                }
            });
        });

        document.querySelectorAll('.remove-btn').forEach(button => {
            button.addEventListener('click', function(e) {
                if (!confirm('Are you sure you want to remove this item from your cart?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
--%>