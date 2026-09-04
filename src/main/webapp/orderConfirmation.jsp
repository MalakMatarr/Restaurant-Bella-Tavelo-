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
	 
	    <div class="text-center mb-4">
	 
	        <div class="confirmation-check">&#10003;</div>
	 
	        <h2 class="mt-3">Thank you! Your order has been placed.</h2>
	 
	        <p class="text-muted">Order #${order.orderId} &middot;
	 
	            <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, hh:mm a"/>
	 
	        </p>
	 
	    </div>
	
	    <div class="row justify-content-center">
	
	        <div class="col-lg-7">
	
	            <div class="card shadow-sm mb-4">
	
	                <div class="card-body">
	
	                    <h5 class="card-title mb-3">Order Details</h5>
	
	                    <table class="table">
	
	                        <thead class="table-light">
	
	                            <tr><th>Item</th><th>Add-ons</th><th>Qty</th><th>Subtotal</th></tr>
	
	                        </thead>
	
	                        <tbody>
	
	                            <c:forEach var="item" items="${order.items}">
	
	                                <tr>
	
	                                    <td>${item.foodName}</td>
	
	                                    <td>
	
	                                        <c:choose>
	
	                                            <c:when test="${empty item.addons}">&mdash;</c:when>
	
	                                            <c:otherwise>${item.addons}</c:otherwise>
	
	                                        </c:choose>
	
	                                    </td>
	
	                                    <td>${item.quantity}</td>
	
	                                    <td>RM <fmt:formatNumber value="${item.subtotal}" pattern="0.00"/></td>
	
	                                </tr>
	
	                            </c:forEach>
	
	                        </tbody>
	
	                        <tfoot>
	
	                            <tr>
	
	                                <th colspan="3" class="text-end">Total Paid</th>
	
	                                <th>RM <fmt:formatNumber value="${order.totalAmount}" pattern="0.00"/></th>
	
	                            </tr>
	
	                        </tfoot>
	
	                    </table>
	
	                    <hr>
	
	                    <p class="mb-1"><strong>Status:</strong> ${order.status}</p>
	
	                    <p class="mb-1"><strong>Payment Method:</strong> ${order.paymentMethod}</p>
	
	                    <p class="mb-1"><strong>Delivery Address:</strong> ${order.deliveryAddress}</p>
	
	                    <p class="mb-0"><strong>Contact Phone:</strong> ${order.contactPhone}</p>
	
	                </div>
	
	            </div>
	
	            <div class="text-center">
	
	                <a href="MenuServlet" class="btn btn-primary">Order More Food</a>
	
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
	
</body>

</html>
