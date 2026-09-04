<%@ page import="java.util.List" %>
<%@ page import="model.MenuItem" %>
<%@ page import="model.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">  

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Bella Tavelo </title>

    <link rel="stylesheet" href="css/global.css">

    <link rel="stylesheet" href="css/Menu.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

    <script src="js/Menu.js" defer></script>

</head>

<body>

    <!-- NAVIGATION BAR -->

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo </div>

            <nav class="nav-links">
                
                <a href="homepage.jsp"> Home </a>

				<a class="active" href="MenuServlet"> Menu </a>

				<a href="about.jsp"> About </a>

				<a href="contact.jsp"> Contact </a>

				<a href="faq.jsp"> FAQ </a>

            </nav>

			<%
			    String userName = (String) session.getAttribute("userName");
			%>
			
			<div class="nav-buttons">
			
			    <% if (userName != null) { %>
			
			        <span class="welcome-text">Hi, <%= userName %></span>
			        
			        <a href="MyOrders" class="login-btn">My Orders</a>
			        
			        <a href="LogoutServlet" class="login-btn">Logout</a>
			
			    <% } else { %>
			
			        <a href="login.html" class="login-btn">Login / Register</a>
			
			    <% } %>
			
			    <a href="cart.jsp" class="cart-btn" aria-label="View cart">
			        
			        <span class="material-symbols-outlined">shopping_cart</span>
			    
			    </a>
			
			</div>
			
        </div>

    </header>


    <main class="menu-page">

        <!-- SIMPLE HEADER -->

        <section class="menu-hero container">

            <h1> Our Menu </h1>

            <p> Explore our dishes by category, choose your add-ons, and add them to your cart. </p>

        </section>


        <!-- CATEGORY FILTER (built from the categories table) -->

        <section class="category-filter container" id="categoryFilter">

            <button class="filter-btn active" data-category="all"> All </button>

            <%
                @SuppressWarnings("unchecked")
                List<Category> categories = (List<Category>) request.getAttribute("categories");

                if (categories != null) {
                    for (Category cat : categories) {
            %>
                        <button class="filter-btn" data-category="<%= cat.getCategoryName() %>"><%= cat.getCategoryName() %></button>
            <%
                    }
                }
            %>

        </section>


        <!-- MENU ITEMS (looped from menu_items table via MenuServlet) -->

        <section class="menu-items container" id="menuItems">

            <%
                @SuppressWarnings("unchecked")
                List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");

                if (menuItems == null || menuItems.isEmpty()) {
		            %>
		            
		                    <p> No menu items available right now. </p>
		            
		            <%
                } 
                
                else {
                    for (MenuItem item : menuItems) {
			            %>
			
			                <div class="menu-card" data-category="<%= item.getCategoryName() %>">
			
			                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>">
			
			                    <div class="card-body">
			                    
			                        <h3><%= item.getName() %></h3>
			                    
			                        <span class="item-price">RM<%= String.format("%.2f", item.getPrice()) %></span>
			
			                        <div class="quantity-control">
			                    
			                            <button class="qty-btn" data-action="decrease">-</button>
			                    
			                            <input type="number" class="qty-input" value="1" min="1">
			                    
			                            <button class="qty-btn" data-action="increase">+</button>
			                    
			                        </div>
			
			                        <div class="card-buttons">
			                    
			                            <button class="details-btn" data-modal-target="modal-<%= item.getItemId() %>"> Details </button>
			                    
			                            <button class="add-to-cart-btn" data-item-id="<%= item.getItemId() %>" data-item-price="<%= item.getPrice() %>"> Add to Cart </button>
			                    
			                        </div>
			                    
			                    </div>
			
			                </div>
			
			            <%
                    }
                }
            %>

        </section>

    </main>


    <!-- DETAIL MODALS (one per item, hidden until "View Details" is clicked) -->

    <%
        if (menuItems != null) {
            for (MenuItem item : menuItems) {
    %>

            <div class="modal-overlay" id="modal-<%= item.getItemId() %>">

                <div class="modal-box">

                    <button class="modal-close" data-modal-close> &times; </button>

                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>">

                    <div class="modal-content">

                        <div class="item-header">
                       
                            <h3><%= item.getName() %></h3>
                       
                            <span class="item-price">RM<%= String.format("%.2f", item.getPrice()) %></span>
                       
                        </div>

                        <p class="item-description"><%= item.getDescription() %></p>

                        <p class="item-ingredients"><strong>Ingredients:</strong> <%= item.getIngredients() %></p>

                        <%
                            if (item.getNutritionInfo() != null && !item.getNutritionInfo().isEmpty()) {
		                        %>
		                                <p class="item-nutrition"><strong>Nutrition:</strong> <%= item.getNutritionInfo() %></p>
		                        <%
                            }
                        %>

                        <div class="item-actions">
                         
                            <div class="quantity-control">
                         
                                <button class="qty-btn" data-action="decrease">-</button>
                         
                                <input type="number" class="qty-input" value="1" min="1">
                         
                                <button class="qty-btn" data-action="increase">+</button>
                         
                            </div>
                         
                            <button class="add-to-cart-btn" data-item-id="<%= item.getItemId() %>" data-item-price="<%= item.getPrice() %>"> Add to Cart </button>
                        
                        </div>

                    </div>

                </div>

            </div>

    <%
            }
        }
    %>


    <!-- FOOTER -->

    <footer>

        <div class="footer-container">

            <div class="footer-bottom"> Group 09 © 2026 </div>

            <div class="footer-links">

                <a href="privacypolicy.html"> Privacy Policy </a>

                <a href="termsandservices.html"> Terms & Services </a>

            </div>

        </div>

    </footer>

</body>

</html>
