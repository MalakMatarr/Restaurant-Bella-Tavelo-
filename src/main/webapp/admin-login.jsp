<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Admin Login | Bella Tavelo </title>

    <link rel="stylesheet" href="${ctx}/css/global.css">

    <link rel="stylesheet" href="${ctx}/css/login.css">

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

</head>

<body>

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links"></nav>

            <div class="nav-buttons"></div>

        </div>

    </header>

    <main class="login-main">

        <section class="login-section container">

            <div class="login-card">

                <span class="login-tag"> Bella Tavelo </span>

                <h1> Admin Login </h1>

                <h3> Restricted Access </h3>

                <c:if test="${param.error == 'invalid'}">
                    <div id="message" style="color:#f2a2a8;margin:12px 0;"> Incorrect email or password. </div>
                </c:if>

                <p>
                    Sign in with your administrator account to manage
                    the menu, categories, and orders.
                </p>

                <form id="adminLoginForm" action="${ctx}/AdminLoginServlet" method="post">

                    <div class="form-group">
                        <label for="email"> Email Address </label>
                        <input type="email" id="email" name="email" placeholder="Enter your admin email" required>
                    </div>

                    <div class="form-group">
                        <label for="password"> Password </label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <button type="submit" class="login-submit-btn"> Login </button>

                </form>

            </div>

            <div class="login-image">

                <div class="login-overlay"></div>

                <div class="login-image-content">
                    <span> Admin Panel </span>
                    <h2> Manage Bella Tavelo </h2>
                    <p> Menu items, categories, and customer orders, all in one place. </p>
                </div>

            </div>

        </section>

    </main>

    <footer>

        <div class="footer-container">

            <div class="footer-bottom"> &copy; 2026 Bella Tavelo. All rights reserved. </div>

        </div>

    </footer>

</body>

</html>
