<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Admin Dashboard | Bella Tavelo </title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/global.css">
</head>

<body class="dark-page">

    <!-- NAVIGATION BAR -->

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links">

                <a class="active" href="${pageContext.request.contextPath}/AdminDashboardServlet"> Dashboard </a>

            </nav>

            <div class="nav-buttons">

                <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="login-btn"> Logout </a>

            </div>

        </div>

    </header>


    <main class="page-section">

        <section class="page-hero-content container">

            <span class="page-eyebrow"> Admin Panel </span>

            <h1 class="page-title"> Admin Dashboard </h1>

            <p class="page-subtitle"> Manage the menu, categories, and customer orders for Bella Tavelo. </p>

        </section>

        <section class="grid-3 container" style="margin-top:50px;">

            <a class="admin-card card-hover" href="${pageContext.request.contextPath}/AddFoodServlet" style="padding:32px;display:block;">
                <h2> Add Food </h2>
                <p> Create a brand new menu item and publish it to the menu. </p>
            </a>

            <a class="admin-card card-hover" href="${pageContext.request.contextPath}/ManageFoodServlet" style="padding:32px;display:block;">
                <h2> Manage Food </h2>
                <p> Edit or delete existing dishes, and toggle availability. </p>
            </a>

            <a class="admin-card card-hover" href="${pageContext.request.contextPath}/ManageCategoriesServlet" style="padding:32px;display:block;">
                <h2> Manage Categories </h2>
                <p> Add, edit, or remove menu categories. </p>
            </a>

            <a class="admin-card card-hover" href="${pageContext.request.contextPath}/ViewOrdersServlet" style="padding:32px;display:block;">
                <h2> View Orders </h2>
                <p> See every customer order, its items, total, and status. </p>
            </a>
     
        </section>

    </main>


    <footer>

        <div class="footer-container">

            <div class="footer-bottom"> &copy; 2026 Bella Tavelo. All rights reserved. </div>

        </div>

    </footer>

</body>

</html>
