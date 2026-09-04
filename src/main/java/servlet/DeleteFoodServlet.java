package servlet;

import java.io.IOException;

import dao.AdminMenuDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteFoodServlet")
public class DeleteFoodServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public DeleteFoodServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int itemId = Integer.parseInt(request.getParameter("id"));

        AdminMenuDao adminMenuDao = new AdminMenuDao();
        boolean success = adminMenuDao.deleteItem(itemId);

        if (success) {
            response.sendRedirect("ManageFoodServlet?success=deleted");
        } else {
            response.sendRedirect("ManageFoodServlet?error=inuse");
        }
    }
}

