<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Edit Food | Bella Tavelo Admin </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">

</head>

<body class="dark-page">

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links">

                <a href="${pageContext.request.contextPath}/AdminDashboardServlet"> Dashboard </a>

                <a class="active" href="${pageContext.request.contextPath}/ManageFoodServlet"> Manage Food </a>

                <a href="${pageContext.request.contextPath}/ManageCategoriesServlet"> Categories </a>

                <a href="${pageContext.request.contextPath}/ViewOrdersServlet"> Orders </a>

            </nav>

            <div class="nav-buttons">

                <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="login-btn"> Logout </a>

            </div>

        </div>

    </header>

    <main class="page-section">

        <section class="page-hero-content container">

            <span class="page-eyebrow"> Admin Panel </span>

            <h1 class="page-title"> Edit Food </h1>

            <p class="page-subtitle"> Update the details for this menu item. </p>

        </section>

        <section class="container" style="max-width:760px;margin-top:40px;">

            <c:if test="${param.error == 'failed'}">
                <p style="color:#f4d36d;margin-bottom:20px;"> Something went wrong while saving your changes. Please try again. </p>
            </c:if>

            <c:if test="${empty item}">
                <p style="color:#f4d36d;"> That menu item could not be found. </p>
            </c:if>

            <c:if test="${not empty item}">

                <form class="form-card" action="${pageContext.request.contextPath}/EditFoodServlet" method="post">

                    <input type="hidden" name="itemId" value="${item.itemId}">

                    <div class="form-row">

                        <div class="form-group">
                            <label for="name"> Name </label>
                            <input type="text" id="name" name="name" value="${item.name}" required>
                        </div>

                        <div class="form-group">
                            <label for="categoryId"> Category </label>
                            <select id="categoryId" name="categoryId" required>
                                <c:forEach var="cat" items="${categories}">
                                    <c:choose>
                                        <c:when test="${cat.categoryId == item.categoryId}">
                                            <option value="${cat.categoryId}" selected>${cat.categoryName}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>

                    </div>

                    <div class="form-group" style="margin-top:18px;">
                        <label for="description"> Description </label>
                        <textarea id="description" name="description">${item.description}</textarea>
                    </div>

                    <div class="form-group" style="margin-top:18px;">
                        <label for="ingredients"> Ingredients </label>
                        <textarea id="ingredients" name="ingredients">${item.ingredients}</textarea>
                    </div>

                    <div class="form-group" style="margin-top:18px;">
                        <label for="nutritionInfo"> Nutrition Information </label>
                        <input type="text" id="nutritionInfo" name="nutritionInfo" value="${item.nutritionInfo}">
                    </div>

                    <div class="form-row" style="margin-top:18px;">

                        <div class="form-group">
                            <label for="price"> Price (RM) </label>
                            <input type="number" id="price" name="price" step="0.01" min="0" value="${item.price}" required>
                        </div>

                        <div class="form-group">
                            <label for="imageUrl"> Image URL </label>
                            <input type="text" id="imageUrl" name="imageUrl" value="${item.imageUrl}">
                        </div>

                    </div>

                    <div class="form-group" style="margin-top:18px;flex-direction:row;align-items:center;gap:10px;">
                        <c:choose>
                            <c:when test="${item.available}">
                                <input type="checkbox" id="available" name="available" style="width:auto;" checked>
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" id="available" name="available" style="width:auto;">
                            </c:otherwise>
                        </c:choose>
                        <label for="available" style="margin:0;"> Available on the menu </label>
                    </div>

                    <button type="submit" class="btn-primary" style="margin-top:26px;border:none;"> Save Changes </button>

                </form>

            </c:if>

        </section>

    </main>

    <footer>

        <div class="footer-container">

            <div class="footer-bottom"> &copy; 2026 Bella Tavelo. All rights reserved. </div>

        </div>

    </footer>

</body>

</html>
