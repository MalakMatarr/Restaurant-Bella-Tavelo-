package servlet;

import dao.OrderDAO;
import model.Order;
import model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/MyOrders")
public class MyOrdersServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.html?message=Please log in to view your orders");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            List<Order> orders = orderDAO.getOrdersByUser(user.getId());
            request.setAttribute("orders", orders);
            RequestDispatcher dispatcher = request.getRequestDispatcher("myOrders.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                    "We couldn't load your orders right now. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("myOrders.jsp");
            dispatcher.forward(request, response);
        }
    }
}
