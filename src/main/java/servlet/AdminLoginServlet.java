package servlet;

import java.io.IOException;

import dao.AdminDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Admin;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public AdminLoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDao adminDao = new AdminDao();
        Admin admin = adminDao.loginAdmin(email, password);

        if (admin == null) {
          
            response.sendRedirect("admin-login.jsp?error=invalid");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("adminUser", admin);
        session.setAttribute("isAdmin", true);

        response.sendRedirect("AdminDashboardServlet");
    }
}
