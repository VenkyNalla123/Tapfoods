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
            <a href="#offers"><i class="fas fa-percent"></i> Offers</a>
            <a href="#help"><i class="fas fa-question-circle"></i> Help</a>
            <a href="Cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a>
            <% User user = (User) session.getAttribute("user");
            if (user != null) { %>
                <span class="username"><%= user.getUsername() %></span>
                <!-- Logout link with confirmation -->
                <a href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>
            <% } else { %>
                <a href="Login.html">Sign In</a>
                <a href="Registration.html">Sign Up</a>
            <% } %>
        </div>
    </div>
</header>

</body>
</html>
    

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















<%-- This is a JSP comment for server-side logic
body {
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f8f8;
    color: #333;
}

header {
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    padding: 15px 0;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

.logo {
    font-size: 24px;
    font-weight: 700;
    color: #fc8019;
    text-decoration: none;
}

.nav-links {
    display: flex;
    gap: 20px;
    align-items: center;
}

.nav-links a {
    color: #3d4152;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
}

.nav-links a:hover {
    color: #fc8019;
}

.search-container {
    display: flex;
    align-items: center;
    background-color: #f0f0f0;
    border-radius: 4px;
    padding: 5px 10px;
    margin-right: 20px;
}

.search-container input {
    border: none;
    background: transparent;
    padding: 5px;
    font-size: 14px;
    width: 200px;
}

.search-container button {
    background: none;
    border: none;
    cursor: pointer;
    color: #686b78;
}

.main-content {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
}

.section-title {
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 20px;
    color: #000;
}

.food-categories {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 40px;
}

.category-item {
    text-align: center;
    width: calc(100% / 7 - 20px);
}

.category-item img {
    width: 100%;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 10px;
}

.category-item p {
    font-size: 14px;
    margin: 0;
    font-weight: 500;
}

.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    justify-content: center;
}

.restaurant-card {
    background-color: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    max-width: 280px;
    height: 300px;
    display: flex;
    flex-direction: column;
}

.restaurant-image {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.restaurant-info {
    padding: 10px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.restaurant-name {
    font-size: 16px;
    font-weight: 700;
    margin: 0 0 4px;
    color: #000;
}

.restaurant-cuisine {
    font-size: 12px;
    color: #686b78;
    margin-bottom: 4px;
}

.restaurant-details {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 12px;
    color: #535665;
    margin-bottom: 4px;
}

.rating {
    display: flex;
    align-items: center;
    padding: 2px 5px;
    background-color: #2e8540;
    color: #fff;
    border-radius: 4px;
    font-weight: 600;
}

.rating i {
    font-size: 12px;
    margin-right: 3px;
}

.delivery-time {
    font-weight: 600;
    color: #1c1c1c;
}

.restaurant-address {
    font-size: 11px;
    color: #686b78;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.restaurant-status {
    font-size: 11px;
    font-weight: 600;
    color: #48c479;
}

footer {
    background-color: #f0f0f0;
    color: #3d4152;
    text-align: center;
    padding: 20px;
    margin-top: 40px;
}



 --%>

