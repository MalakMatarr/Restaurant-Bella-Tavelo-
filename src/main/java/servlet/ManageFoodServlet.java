package servlet;

import java.io.IOException;
import java.util.List;

import dao.AdminMenuDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MenuItem;

@WebServlet("/ManageFoodServlet")
public class ManageFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ManageFoodServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdminMenuDao adminMenuDao = new AdminMenuDao();
        List<MenuItem> menuItems = adminMenuDao.getAllItemsForAdmin();

        request.setAttribute("menuItems", menuItems);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manage-food.jsp");
        dispatcher.forward(request, response);
    }
}

