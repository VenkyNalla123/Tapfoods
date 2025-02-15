<%@ page import="java.util.*,com.dao.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tap Foods - Delicious Food Delivered</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="CssFolder/home_jsp.css">
    <link rel="stylesheet" href="CssFolder/home_jsp.css">
</head>
<body>
    <header>
    <div class="header-container">
        <a href="#" class="logo">Tap Foods</a>
        <div class="nav-links">
            <div class="search-container">
                <input type="text" placeholder="Search for food or restaurants">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
            <a href="#offers">Offers</a>
            <a href="#help">Help</a>
            <% User user = (User) session.getAttribute("user");
            if (user != null) { %>
                <span class="username"><%= user.getUsername() %></span>
                <!-- Logout link with confirmation -->
                <a href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
            <% } else { %>
                <a href="login.jsp">Sign In</a>
                <a href="registration.jsp">Sign Up</a>
            <% } %>
        </div>
    </div>
</header>
    

    <div class="main-content">
        <h2 class="section-title">Welcome, <%= user != null ? user.getUsername() : "Guest" %>! What's on your mind?</h2>
        <div class="food-categories">
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/biryani.jpg" alt="Biryani">
                <p>Biryani</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/pizza.jpg" alt="Pizza">
                <p>Pizza</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/burger.jpg" alt="Burger">
                <p>Burger</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/sushi.jpg" alt="Sushi">
                <p>Sushi</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/pasta.jpg" alt="Pasta">
                <p>Pasta</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/dessert.jpg" alt="Dessert">
                <p>Dessert</p>
            </div>
            <div class="category-item">
                <img src="<%= request.getContextPath() %>/images/salad.jpg" alt="Salad">
                <p>Salad</p>
            </div>
        </div>

        <h3 class="section-title">Top Restaurants Near You</h3>
        <div class="sorting-options">
            <span>Sort by:</span>
            <button onclick="sortRestaurants('rating')">Rating</button>
            <button onclick="sortRestaurants('deliveryTime')">Delivery Time</button>
        </div>

        <div class="restaurant-grid" id="restaurantGrid">
            <% ArrayList<Restaurant> rlist = (ArrayList<Restaurant>) session.getAttribute("restaurantList");
            for (Restaurant r : rlist) {
                String imagePath = r.getImagePath() != null && !r.getImagePath().isEmpty() ? r.getImagePath() : "/images/default.jpg";
            %>
            <a href="Menu?restaurantId=<%= r.getRestaurantId()
            %>">
           
            
                <div class="restaurant-card" data-rating="<%= r.getRating() %>" data-delivery-time="<%= r.getDeliveryTime() %>">
                    <div class="restaurant-image-container">
                        <img class="restaurant-image" src="<%= imagePath.startsWith("http") ? imagePath : request.getContextPath() + imagePath %>" alt="Image of <%= r.getRestaurantName() %>">
                    </div>
                    <div class="restaurant-info">
                        <h3 class="restaurant-name"><%= r.getRestaurantName() %></h3>
                        <p class="restaurant-cuisine"><%= r.getCuisineType() %></p>
                        <div class="restaurant-details">
                            <span class="rating">
                                <i class="fas fa-star"></i> <%= String.format("%.1f", r.getRating()) %>
                            </span>
                            <span class="delivery-time"><%= r.getDeliveryTime() %> mins</span>
                        </div>
                        <p class="restaurant-address"><%= r.getAddress() %></p>
                        <p class="restaurant-status"><%= r.isActive() ? "Open Now" : "Closed" %></p>
                    </div>
                </div>
            </a>
            <% } %>
        </div>
    </div>

    <footer>
        <p>&copy; <%= new Date().getYear() + 1900 %> Tap Foods. All Rights Reserved. | Designed for <strong><%= user != null ? user.getUsername() : "Guest" %></strong>.</p>
    </footer>

    <script>
        function sortRestaurants(criteria) {
            const restaurantGrid = document.getElementById('restaurantGrid');
            const restaurants = Array.from(restaurantGrid.children);
            restaurants.sort((a, b) => {
                const aValue = parseFloat(a.querySelector('.restaurant-card').dataset[criteria === 'rating' ? 'rating' : 'deliveryTime']);
                const bValue = parseFloat(b.querySelector('.restaurant-card').dataset[criteria === 'rating' ? 'rating' : 'deliveryTime']);
                return criteria === 'rating' ? bValue - aValue : aValue - bValue;
            });
            restaurants.forEach(restaurant => restaurantGrid.appendChild(restaurant));
        }
    </script>
</body>
</html>

