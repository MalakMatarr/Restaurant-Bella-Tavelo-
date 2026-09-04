<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title> Bella Tavelo </title>
	
	<link rel="stylesheet" href="css/global.css">

	<link rel="stylesheet" href="css/homepage.css">
	
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

</head>

 

<body>

	<!-- NAVIGATION BAR -->
	
	<header class="navbar">
	
		<div class="nav-container">
		
			<div class="brand"> Bella Tavelo </div>
		
			<nav class="nav-links">
			
				<a class="active" href="homepage.jsp"> Home </a>
				
				<a href="MenuServlet"> Menu </a>			
				
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
	
	

	<!-- INTRODUCTION -->
	
	<section class="hero">
	
		<div class="hero-content">	
		
			<h1> Authentic Italian Cuisine </h1>
			
			<p> Fresh ingredients, handcrafted recipes, and unforgettable flavours delivered to your doorstep. </p>
			
			<div class="hero-buttons">
			
				<a href="MenuServlet" class="btn-primary"> View Menu and Order </a>
				
			</div>
		
		</div>
	
	</section>

	<!-- HOW ORDERING WORKS -->
	<section class="process-section container">
	
		<div class="section-title">

			<h2> How Ordering Works </h2>

			<p> A simple flow that connects the homepage to the menu, cart, checkout, and order confirmation pages. </p>

		</div>

		<div class="process-grid">

			<article class="process-card">

				<span class="process-number"> 01 </span>

				<h3> Browse the Menu </h3>

				<p> Explore dishes by category and view prices, ratings, and details. </p>

			</article>

			<article class="process-card">

				<span class="process-number"> 02 </span>

				<h3> Add to Cart </h3>

				<p> Select quantities and review chosen meals before checkout. </p>

			</article>

			<article class="process-card">

				<span class="process-number"> 03 </span>

				<h3> Confirm Order </h3>

				<p> Log in, checkout, and receive an order confirmation. </p>

			</article>

		</div>

	</section>

	<!-- SPECIAL FOOD -->
	
	<section class="featured container">
	
	    <div class="section-title">
	    
	        <h2> Our Special Food </h2>
	        
	        <p> A curated selection of our finest traditional dishes. </p>
	        
	    </div>
	
	    <div class="cards">
	
			<!-- CARD 1 -->
			
	        <div class="card">
	
	            <div class="card-image">
	            
	                <img src="images/margheritapizza.png" alt="Margherita Pizza">
	                
	                <div class="rating">
	                
						<span class="stars">&#9733;</span>
						<span class="rating-number"> 4.8 </span>
						
					</div>
					
	            </div>
	
	            <div class="card-content">
	            
	                <div class="card-header">
	                
					    <h3> Margherita Pizza </h3>
					    <span class="price"> RM28 </span>
					    
					</div>
					
	                <p> Classic Neapolitan style with tomato sauce, mozzarella, and fragrant basil. </p>
	
	                <a href="MenuServlet" class="detail-btn"> View Menu </a>
	
	            </div>
	            
	        </div>
	
	        <!-- CARD 2 -->
	        
	        <div class="card">
	
	            <div class="card-image">
	            
	            
	                <img src="images/carbonarapasta.png" alt="Spaghetti Carbonara">
	
	                <div class="rating">
				
						<span class="stars">&#9733;</span>
						<span class="rating-number"> 4.9 </span>
				
					</div>
	            
	            </div>
	
	            <div class="card-content">
	
					<div class="card-header">
				
					    <h3> Spaghetti Carbonara </h3>
					    <span class="price"> RM32 </span>
				
					</div>
	
	                <p> Authentic Roman pasta with creamy sauce and bold peppery flavours. </p>
	
	                <a href="MenuServlet" class="detail-btn"> View Menu </a>
	
	            </div>
	            
	        </div>
	
	        <!-- CARD 3 -->
	        
	        <div class="card">
	
	            <div class="card-image">
	            
	                <img src="images/tiramisu.png" alt="Tiramisu Classico">
	
	                <div class="rating">
				
						<span class="stars">&#9733;</span>
						<span class="rating-number"> 4.7 </span>
				
					</div>
	            
	            </div>
	
	            <div class="card-content">
	            
					<div class="card-header">
				
					    <h3> Tiramisu Classico </h3>
					    <span class="price"> RM22 </span>
				
					</div>
	
	                <p> Espresso soaked ladyfingers with mascarpone cream. </p>
	
	                <a href="MenuServlet" class="detail-btn"> View Menu </a>
	
	            </div>
	            
	        </div>
	
	    </div>
	
	</section>
	
	
	
	<!-- FOOTER -->
	
	<footer>
	
	    <div class="footer-container">
	
	        <div class="footer-bottom"> Group 09 &copy; 2026 </div>
	
	        <div class="footer-links">
	        
	            <a href="privacypolicy.html"> Privacy Policy </a>
	        
	            <a href="termsandservices.html"> Terms & Services </a>
	            
	        </div>
	
	    </div>
	
	</footer>

</body>

</html>