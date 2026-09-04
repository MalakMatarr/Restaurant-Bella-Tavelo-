package servlet;

import java.io.IOException;
import java.util.List;

import dao.CategoryDao;
import dao.AdminMenuDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.MenuItem;

@WebServlet("/AddFoodServlet")
public class AddFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public AddFoodServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDao categoryDao = new CategoryDao();
        List<Category> categories = categoryDao.getAllCategories();

        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/add-food.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String ingredients = request.getParameter("ingredients");
        String nutritionInfo = request.getParameter("nutritionInfo");
        String priceParam = request.getParameter("price");
        String categoryIdParam = request.getParameter("categoryId");
        String imageUrl = request.getParameter("imageUrl");
        String available = request.getParameter("available"); // checkbox

        MenuItem item = new MenuItem();
        item.setName(name);
        item.setDescription(description);
        item.setIngredients(ingredients);
        item.setNutritionInfo(nutritionInfo);
        item.setPrice(Double.parseDouble(priceParam));
        item.setCategoryId(Integer.parseInt(categoryIdParam));
        item.setImageUrl(imageUrl);
        item.setAvailable(available != null);

        AdminMenuDao adminMenuDao = new AdminMenuDao();
        boolean success = adminMenuDao.addItem(item);

        if (success) {
            response.sendRedirect("ManageFoodServlet?success=added");
        } else {
            response.sendRedirect("AddFoodServlet?error=failed");
        }
    }
}
