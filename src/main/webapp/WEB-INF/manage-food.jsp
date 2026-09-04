<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Manage Food | Bella Tavelo Admin </title>

    <link rel="stylesheet" href="../css/global.css">

</head>

<body class="dark-page">

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links">

                <a href="../AdminDashboardServlet"> Dashboard </a>

                <a class="active" href="../ManageFoodServlet"> Manage Food </a>

                <a href="../ManageCategoriesServlet"> Categories </a>

                <a href="../ViewOrdersServlet"> Orders </a>

            </nav>

            <div class="nav-buttons">

                <a href="../AdminLogoutServlet" class="login-btn"> Logout </a>

            </div>

        </div>

    </header>

    <main class="page-section">

        <section class="page-hero-content container">

            <span class="page-eyebrow"> Admin Panel </span>

            <h1 class="page-title"> Manage Food </h1>

            <p class="page-subtitle"> Every dish currently in the menu_items table. </p>

        </section>

        <section class="container" style="margin-top:30px;">

            <div style="display:flex;justify-content:flex-end;margin-bottom:20px;">
                <a href="../AddFoodServlet" class="btn-primary"> + Add Food </a>
            </div>

            <c:if test="${param.success == 'added'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Menu item added successfully. </p>
            </c:if>
            <c:if test="${param.success == 'updated'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Menu item updated successfully. </p>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Menu item deleted successfully. </p>
            </c:if>
            <c:if test="${param.error == 'inuse'}">
                <p style="color:#f4d36d;margin-bottom:16px;"> This item couldn't be deleted because it appears in existing orders. </p>
            </c:if>

            <div class="table-card">

                <table class="data-table">

                    <thead>
                        <tr>
                            <th> Name </th>
                            <th> Category </th>
                            <th> Price </th>
                            <th> Available </th>
                            <th> Actions </th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:if test="${empty menuItems}">
                            <tr>
                                <td colspan="5"> No menu items yet. </td>
                            </tr>
                        </c:if>

                        <c:forEach var="item" items="${menuItems}">
                            <tr>
                                <td>${item.name}</td>
                                <td>${item.categoryName}</td>
                                <td class="price">RM <fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.available}">
                                            <span class="status-badge"> Available </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge" style="background:rgba(255,255,255,.08);color:#f4ede2;"> Hidden </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="../EditFoodServlet?id=${item.itemId}" style="color:var(--gold);font-weight:700;margin-right:14px;"> Edit </a>
                                    <a href="../DeleteFoodServlet?id=${item.itemId}"
                                       style="color:#f2a2a8;font-weight:700;"
                                       onclick="return confirm('Delete ${item.name}? This cannot be undone.');"> Delete </a>
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
