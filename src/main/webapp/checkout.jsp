<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Bella Tavelo</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <link rel="stylesheet" href="css/order.css">

    <link rel="stylesheet" href="css/global.css">
	
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
	
</head>



<body>

	<header class="navbar">
	
		<div class="nav-container">
	
			<div class="brand"> Bella Tavelo </div>
	
			<nav class="nav-links">
	
				<a href="homepage.jsp"> Home </a>
	
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
	
	<div class="container my-5">
	
	    <h2 class="mb-4">Checkout</h2>
	
	    <c:if test="${not empty errorMessage}">
	
	        <div class="alert alert-danger">${errorMessage}</div>
	
	    </c:if>
	
	    <div class="row">
	
	        <div class="col-lg-7 mb-4">
	
	            <div class="card shadow-sm">
	
	                <div class="card-body">
	
	                    <h5 class="card-title mb-3">Delivery &amp; Payment Details</h5>
	
	                    <form id="checkoutForm" action="Checkout" method="post" novalidate>
	
	                        <div class="mb-3">
	
	                            <label for="deliveryAddress" class="form-label">Delivery Address</label>
	
	                            <textarea class="form-control" id="deliveryAddress" name="deliveryAddress"
	                                      rows="3" required minlength="10"
	                                      placeholder="Unit / street / city / postcode"></textarea>
	                    
	                            <div class="invalid-feedback">Please enter a complete address (min. 10 characters).</div>
	                    
	                        </div>
	
	                        <div class="mb-3">
	                    
	                            <label for="contactPhone" class="form-label">Contact Phone</label>
	                    
	                            <input type="tel" class="form-control" id="contactPhone" name="contactPhone"
	                                   required placeholder="e.g. 012-3456789">
	                    
	                            <div class="invalid-feedback">Please enter a valid phone number.</div>
	                    
	                        </div>
	
	                        <div class="mb-3">
	
	                            <label class="form-label d-block">Payment Method</label>
	
	                            <div class="form-check">
	
	                                <input class="form-check-input" type="radio" name="paymentMethod"
	                                       id="payCod" value="COD" checked>
	
	                                <label class="form-check-label" for="payCod">Cash on Delivery</label>
	
	                            </div>
	
	                            <div class="form-check">
	
	                                <input class="form-check-input" type="radio" name="paymentMethod"
	                                       id="payCard" value="CARD">
	
	                                <label class="form-check-label" for="payCard">Credit / Debit Card</label>
	
	                            </div>
	
	                            <div class="form-check">
	
	                                <input class="form-check-input" type="radio" name="paymentMethod"
	                                       id="payOnline" value="ONLINE_BANKING">
	
	                                <label class="form-check-label" for="payOnline">Online Banking</label>
	
	                            </div>
	
	                        </div>
	
	                        <div id="cardFields" class="border rounded p-3 mb-3 d-none">
	
	                            <div class="mb-3">
	
	                                <label for="cardNumber" class="form-label">Card Number</label>
	
	                                <input type="text" class="form-control" id="cardNumber" name="cardNumber"
	                                       placeholder="1234 5678 9012 3456" maxlength="19">
	
	                                <div class="invalid-feedback">Enter a valid 16-digit card number.</div>
	
	                            </div>
	
	                            <div class="row">
	
	                                <div class="col-6 mb-3">
	
	                                    <label for="cardExpiry" class="form-label">Expiry (MM/YY)</label>
	
	                                    <input type="text" class="form-control" id="cardExpiry" name="cardExpiry"
	                                           placeholder="MM/YY" maxlength="5">
	
	                                    <div class="invalid-feedback">Enter a valid expiry date.</div>
	
	                                </div>
	
	                                <div class="col-6 mb-3">
	
	                                    <label for="cardCvv" class="form-label">CVV</label>
	
	                                    <input type="text" class="form-control" id="cardCvv" name="cardCvv"
	                                           placeholder="123" maxlength="4">
	
	                                    <div class="invalid-feedback">Enter a valid CVV.</div>
	
	                                </div>
	
	                            </div>
	
	                        </div>
	
	                        <div id="formErrorBox" class="alert alert-danger d-none"></div>
	
	                        <button type="submit" class="btn btn-success btn-lg w-100">Place Order</button>
	                  
	                    </form>
	      
	                </div>
	      
	            </div>
	      
	        </div>
	
	        <div class="col-lg-5">
	
	            <div class="card shadow-sm">
	
	                <div class="card-body">
	
	                    <h5 class="card-title mb-3">Order Summary</h5>
	
	                    <ul class="list-group list-group-flush">
	
	                        <c:forEach var="item" items="${cart}">
	
	                            <li class="list-group-item d-flex justify-content-between">
	
	                                <span>
	                                    ${item.foodName} &times; ${item.quantity}
	
	                                    <c:if test="${not empty item.addons}">
	
	                                        <br><small class="text-muted">${item.addons}</small>
	
	                                    </c:if>

	                                </span>

	                                <span>RM <fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></span>
	                            </li>
	
	                        </c:forEach>
	
	                        <li class="list-group-item d-flex justify-content-between fw-bold">
	
	                            <span>Total</span>
	
	                            <span>RM <fmt:formatNumber value="${cartTotal}" pattern="0.00"/></span>
	
	                        </li>
	
	                    </ul>
	
	                </div>
	
	            </div>
	
	        </div>
	
	    </div>
	
	</div>
	
	<footer>
	
	    <div class="footer-container">
	
	        <div class="footer-bottom"> Group 09 © 2026 </div>
	
	        <div class="footer-links">
	
	            <a href="privacypolicy.html"> Privacy Policy </a>
	
	            <a href="termsandservices.html"> Terms & Services </a>
	
	        </div>
	
	    </div>
	
	</footer>
	
	<script src="js/checkout-validation.js"></script>
	
</body>

</html>
