<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> View Orders | Bella Tavelo Admin </title>

    <link rel="stylesheet" href="../css/global.css">

</head>



<body class="dark-page">

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links">

                <a href="../AdminDashboardServlet"> Dashboard </a>

                <a href="../ManageFoodServlet"> Manage Food </a>

                <a href="../ManageCategoriesServlet"> Categories </a>

                <a class="active" href="../ViewOrdersServlet"> Orders </a>

            </nav>

            <div class="nav-buttons">

                <a href="../AdminLogoutServlet" class="login-btn"> Logout </a>

            </div>

        </div>

    </header>

    <main class="page-section">

        <section class="page-hero-content container">

            <span class="page-eyebrow"> Admin Panel </span>

            <h1 class="page-title"> Customer Orders </h1>

            <p class="page-subtitle"> Every order placed through Bella Tavelo. </p>

        </section>

        <section class="container" style="margin-top:30px;">

            <div class="table-card">

                <table class="data-table">

                    <thead>
                        <tr>
                            <th> Order ID </th>
                            <th> Customer </th>
                            <th> Items </th>
                            <th> Total </th>
                            <th> Date / Time </th>
                            <th> Status </th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="6"> No orders have been placed yet. </td>
                            </tr>
                        </c:if>

                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#${order.orderId}</td>
                                <td>${order.customerName}</td>
                                <td>${order.itemsSummary}</td>
                                <td class="price">RM <fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, HH:mm"/></td>
                                <td>
                                    <form action="../ViewOrdersServlet" method="post" style="display:flex;gap:8px;align-items:center;">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <select name="status" onchange="this.form.submit()" style="padding:6px 10px;border-radius:8px;background:#1c1714;color:#fff8ed;border:1px solid rgba(245,239,227,.10);">
                                            <c:forEach var="s" items="${statuses}">
                                                <c:choose>
                                                    <c:when test="${s == order.status}">
                                                        <option value="${s}" selected>${s}</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${s}">${s}</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                    </tbody>

                </table>

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
