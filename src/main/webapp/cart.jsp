<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
	
	<meta charset="UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title> Bella Tavelo </title>
    
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
	
	    <h2 class="mb-4">Your Cart</h2>
	
	    <c:if test="${not empty param.cartEmpty}">
	 
	        <div class="alert alert-warning">Your cart is empty. Add some delicious food first!</div>
	 
	    </c:if>
	 
	    <c:if test="${not empty param.added}">
	 
	        <div class="alert alert-success">Item added to your cart.</div>
	 
	    </c:if>
	 
	    <c:if test="${not empty errorMessage}">
	 
	        <div class="alert alert-danger">${errorMessage}</div>
	 
	    </c:if>
	
	    <c:choose>
	
	        <c:when test="${empty cart}">
	
	            <p>Your cart is currently empty.</p>
	
	            <a href="MenuServlet" class="btn btn-primary">Browse Menu</a>
	
	        </c:when>
	
	        <c:otherwise>
	
	            <%-- Compute the total here instead of relying on a request attribute set
	                 elsewhere (e.g. CartServlet), so it's correct no matter how this page
	                 was reached - direct link, redirect after Add to Cart, etc. --%>
	
	            <c:set var="cartTotal" value="0"/>
	
	            <c:forEach var="item" items="${cart}">
	
	                <c:set var="cartTotal" value="${cartTotal + item.subtotal}"/>
	
	            </c:forEach>
	
	            <div class="table-responsive">
	
	                <table class="table align-middle cart-table">
	
	                    <thead class="table-light">
	
	                        <tr>
	
	                            <th>Item</th>
	                            <th>Add-ons</th>
	                            <th>Unit Price</th>
	                            <th>Quantity</th>
	                            <th>Subtotal</th>
	                            <th></th>
	
	                        </tr>
	
	                    </thead>
	
	                    <tbody>
	
	                        <c:forEach var="item" items="${cart}">
	
	                            <tr>
	                                <td data-label="Item">${item.foodName}</td>
	
	                                <td data-label="Add-ons">
	
									    <c:choose>
	
									        <c:when test="${empty item.addons}">&mdash;</c:when>
	
									        <c:otherwise>
	
									            ${item.addons}
	
									            <c:if test="${item.addonsPrice > 0}">
	
									                (+RM <fmt:formatNumber value="${item.addonsPrice}" pattern="0.00"/>)
	
									            </c:if>
	
									        </c:otherwise>
	
									    </c:choose>
	
									</td>
	
	                                <td data-label="Unit Price">RM <fmt:formatNumber value="${item.unitPrice + item.addonsPrice}" pattern="0.00"/></td>
	
	                                <td data-label="Quantity">
	
	                                    <form action="UpdateCart" method="post" class="d-flex align-items-center gap-2">
	
	                                        <input type="hidden" name="foodId" value="${item.foodId}">
	
	                                        <input type="number" name="quantity" min="0" max="20"
	                                               value="${item.quantity}" class="form-control form-control-sm qty-input">
	
	                                        <button type="submit" class="btn btn-sm btn-outline-secondary">Update</button>
	
	                                    </form>
	
	                                </td>
	
	                                <td data-label="Subtotal">RM <fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></td>
	
	                                <td>
	
	                                    <a href="RemoveFromCart?foodId=${item.foodId}"
	                                       class="btn btn-sm btn-outline-danger">Remove</a>
	   
	                                </td>
	   
	                            </tr>
	   
	                        </c:forEach>
	   
	                    </tbody>
	   
	                    <tfoot>
	   
	                        <tr>
	   
	                            <th colspan="4" class="text-end">Total</th>
	   
	                            <th colspan="2">RM <fmt:formatNumber value="${cartTotal}" pattern="0.00"/></th>
	   
	                        </tr>
	   
	                    </tfoot>
	   
	                </table>
	   
	            </div>
	
	            <div class="d-flex justify-content-between mt-4">
	
	                <a href="MenuServlet" class="btn btn-outline-secondary">Continue Shopping</a>
	
	                <a href="Checkout" class="btn btn-success btn-lg">Proceed to Checkout</a>
	
	            </div>
	
	        </c:otherwise>
	
	    </c:choose>
	
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

</body>

</html>
