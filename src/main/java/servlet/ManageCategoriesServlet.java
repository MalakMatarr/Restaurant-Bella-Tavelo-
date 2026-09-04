package servlet;

import java.io.IOException;
import java.util.List;

import dao.CategoryDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;

@WebServlet("/ManageCategoriesServlet")
public class ManageCategoriesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ManageCategoriesServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDao categoryDao = new CategoryDao();
        List<Category> categories = categoryDao.getAllCategories();

        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/manage-categories.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        CategoryDao categoryDao = new CategoryDao();

        if ("add".equals(action)) {

            Category category = new Category();
            category.setCategoryName(request.getParameter("categoryName"));
            category.setDescription(request.getParameter("description"));

            boolean success = categoryDao.addCategory(category);

            response.sendRedirect("ManageCategoriesServlet?" + (success ? "success=added" : "error=failed"));

        } else if ("edit".equals(action)) {

            Category category = new Category();
            category.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            category.setCategoryName(request.getParameter("categoryName"));
            category.setDescription(request.getParameter("description"));

            boolean success = categoryDao.updateCategory(category);

            response.sendRedirect("ManageCategoriesServlet?" + (success ? "success=updated" : "error=failed"));

        } else if ("delete".equals(action)) {

            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            boolean success = categoryDao.deleteCategory(categoryId);

            response.sendRedirect("ManageCategoriesServlet?" + (success ? "success=deleted" : "error=inuse"));

        } else {

            response.sendRedirect("ManageCategoriesServlet");
        }
    }
}

