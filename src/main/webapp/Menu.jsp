<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu - Tap Foods</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="menu.css">
</head>
<body>
    <header>
        <div class="header-container">
            <a href="index.jsp" class="logo">Tap Foods</a>
            <div class="nav-links">
                <div class="search-container">
                    <input type="text" placeholder="Search for dishes">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </div>
                <a href="#offers"><i class="fas fa-percent"></i> Offers</a>
                <a href="#help"><i class="fas fa-question-circle"></i> Help</a>
                <a href="Cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
                <% User user = (User) session.getAttribute("user");
                if (user != null) { %>
                    <span class="username"><%= user.getUsername() %></span>
                    <a href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
                <% } else { %>
                    <a href="Login.html">Sign In</a>
                    <a href="Registration.html">Sign Up</a>
                <% } %>
            </div>
        </div>
    </header>

    <main>
        <div class="restaurant-info">
            <h1><%= request.getAttribute("restaurantName") %></h1>
            <div class="restaurant-details">
                <span class="rating"><i class="fas fa-star"></i> <%= request.getAttribute("rating") %> (<%= request.getAttribute("ratingCount") %> ratings)</span>
                <span class="price">₹<%= request.getAttribute("priceForTwo") %> for two</span>
                <span class="cuisine"><%= request.getAttribute("cuisine") %></span>
                <span class="location"><%= request.getAttribute("location") %></span>
                <span class="delivery-time"><i class="fas fa-clock"></i> <%= request.getAttribute("deliveryTime") %> mins</span>
            </div>
            <p class="free-delivery">Free delivery on orders above ₹199</p>
        </div>

        <h2 class="menu-heading">Menu</h2>

        <div class="menu-container">
            <div class="menu-search">
                <input type="text" id="menuSearch" placeholder="Search for dishes">
            </div>
            <%
                ArrayList<Menu> menuList = (ArrayList<Menu>) request.getAttribute("menuList");
                if (menuList == null || menuList.isEmpty()) {
            %>
                <h2>No menu items available for this restaurant.</h2>
            <%
                } else {
                    for (Menu m : menuList) {
            %>
            <div class="menu-card">
                <div class="menu-image-container">
                    <img src="<%= m.getImagePath() %>" alt="<%= m.getName() %>" />
                </div>
                <div class="menu-details">
                    <h3 class="menu-name"><%= m.getName() %></h3>
                    <p class="menu-description"><%= m.getDescription() %></p>
                    <div class="menu-info">
                        <p class="menu-price">₹<%= m.getPrice() %></p>
                        <p class="menu-availability <%= m.isAvailable() ? "available" : "not-available" %>">
                            <%= m.isAvailable() ? "Available" : "Not Available" %>
                        </p>
                    </div>
                    <form action="Cart" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                        <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </main>

    <script>
        document.getElementById('menuSearch').addEventListener('input', function() {
            let filter = this.value.toLowerCase();
            let menuCards = document.getElementsByClassName('menu-card');
            
            for (let i = 0; i < menuCards.length; i++) {
                let menuName = menuCards[i].getElementsByClassName('menu-name')[0].textContent.toLowerCase();
                let menuDescription = menuCards[i].getElementsByClassName('menu-description')[0].textContent.toLowerCase();
                
                if (menuName.indexOf(filter) > -1 || menuDescription.indexOf(filter) > -1) {
                    menuCards[i].style.display = "";
                } else {
                    menuCards[i].style.display = "none";
                }
            }
        });
    </script>
</body>
</html>













<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Items</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="CssFolder/menu.css">
</head>
<body>
    <div class="menu-container">
        <%
            ArrayList<Menu> menuList = (ArrayList<Menu>) request.getAttribute("menuList");
            if (menuList == null || menuList.isEmpty()) {
        %>
            <h2>No menu items available for this restaurant.</h2>
        <%
            } else {
                for (Menu m : menuList) {
        %>
        <div class="menu-card">
            <div class="menu-image-container">
                <img src="<%= m.getImagePath() %>" alt="<%= m.getName() %>" />
            </div>
            <div class="menu-details">
                <h3 class="menu-name"><%= m.getName() %></h3>
                <p class="menu-description"><%= m.getDescription() %></p>
                <div class="menu-info">
                    <p class="menu-price">$<%= m.getPrice() %></p>
                    <p class="menu-availability <%= m.isAvailable() ? "available" : "not-available" %>">
                        <%= m.isAvailable() ? "Available" : "Not Available" %>
                    </p>
                </div>
                <form action="Cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                    <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
                    <button type="submit" class="add-to-cart">Add to Cart</button>
                </form>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
    <a href="Cart.jsp" class="view-cart-button">View Cart</a>
</body>
</html>
--%>
