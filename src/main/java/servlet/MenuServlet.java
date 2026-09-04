package servlet;

import java.io.IOException;
import java.util.List;

import dao.MenuDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.MenuItem;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MenuServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MenuDao menuDAO = new MenuDao();

        List<MenuItem> menuItems = menuDAO.getAllItems();
        List<Category> categories = menuDAO.getAllCategories();

        request.setAttribute("menuItems", menuItems);
        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Menu.jsp");
        dispatcher.forward(request, response);
    }
}
