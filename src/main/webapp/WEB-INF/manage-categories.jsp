<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title> Manage Categories | Bella Tavelo Admin </title>

    <link rel="stylesheet" href="../css/global.css">

</head>

<body class="dark-page">

    <header class="navbar">

        <div class="nav-container">

            <div class="brand"> Bella Tavelo Admin </div>

            <nav class="nav-links">

                <a href="../AdminDashboardServlet"> Dashboard </a>

                <a href="../ManageFoodServlet"> Manage Food </a>

                <a class="active" href="../ManageCategoriesServlet"> Categories </a>

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

            <h1 class="page-title"> Manage Categories </h1>

            <p class="page-subtitle"> Organize the menu into categories such as Antipasti or Dolci. </p>

        </section>

        <section class="container" style="margin-top:30px;">

            <c:if test="${param.success == 'added'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Category added successfully. </p>
            </c:if>
            <c:if test="${param.success == 'updated'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Category updated successfully. </p>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <p style="color:#8fd19e;margin-bottom:16px;"> Category deleted successfully. </p>
            </c:if>
            <c:if test="${param.error == 'inuse'}">
                <p style="color:#f4d36d;margin-bottom:16px;"> This category couldn't be deleted because menu items still belong to it. Move or delete those items first. </p>
            </c:if>
            <c:if test="${param.error == 'failed'}">
                <p style="color:#f4d36d;margin-bottom:16px;"> Something went wrong. Please try again. </p>
            </c:if>

            <!-- ADD CATEGORY -->

            <form class="form-card" action="../ManageCategoriesServlet" method="post" style="margin-bottom:36px;">

                <input type="hidden" name="action" value="add">

                <div class="form-row">

                    <div class="form-group">
                        <label for="categoryName"> Category Name </label>
                        <input type="text" id="categoryName" name="categoryName" placeholder="e.g. Antipasti" required>
                    </div>

                    <div class="form-group">
                        <label for="description"> Description </label>
                        <input type="text" id="description" name="description" placeholder="Short description">
                    </div>

                </div>

                <button type="submit" class="btn-primary" style="margin-top:20px;border:none;"> + Add Category </button>

            </form>

            <!-- CATEGORY LIST -->

            <div class="table-card">

                <table class="data-table">

                    <thead>
                        <tr>
                            <th> Name </th>
                            <th> Description </th>
                            <th> Actions </th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="3"> No categories yet. </td>
                            </tr>
                        </c:if>

                        <c:forEach var="cat" items="${categories}">

                            <tr id="view-row-${cat.categoryId}">
                                <td>${cat.categoryName}</td>
                                <td>${cat.description}</td>
                                <td>
                                    <a href="#" style="color:var(--gold);font-weight:700;margin-right:14px;"
                                       onclick="document.getElementById('view-row-${cat.categoryId}').style.display='none'; document.getElementById('edit-row-${cat.categoryId}').style.display='table-row'; return false;"> Edit </a>

                                    <form action="../ManageCategoriesServlet" method="post" style="display:inline;"
                                          onsubmit="return confirm('Delete ${cat.categoryName}? Items in this category must be moved or removed first.');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="categoryId" value="${cat.categoryId}">
                                        <button type="submit" style="background:none;border:none;color:#f2a2a8;font-weight:700;padding:0;"> Delete </button>
                                    </form>
                                </td>
                            </tr>

                            <tr id="edit-row-${cat.categoryId}" style="display:none;">
                                <td colspan="3">
                                    <form action="../ManageCategoriesServlet" method="post" style="display:flex;gap:14px;align-items:flex-end;flex-wrap:wrap;">

                                        <input type="hidden" name="action" value="edit">
                                        <input type="hidden" name="categoryId" value="${cat.categoryId}">

                                        <div class="form-group" style="flex:1;min-width:180px;">
                                            <label> Category Name </label>
                                            <input type="text" name="categoryName" value="${cat.categoryName}" required>
                                        </div>

                                        <div class="form-group" style="flex:1;min-width:220px;">
                                            <label> Description </label>
                                            <input type="text" name="description" value="${cat.description}">
                                        </div>

                                        <button type="submit" class="btn-primary" style="border:none;"> Save </button>

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
