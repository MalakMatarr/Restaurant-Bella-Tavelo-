package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

@WebServlet("/ViewOrdersServlet")
public class ViewOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ViewOrdersServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            OrderDAO orderDao = new OrderDAO();
            List<Order> orders = orderDao.getAllOrders();

            List<String> statuses = Arrays.asList(
                    "Pending",
                    "Preparing",
                    "Out for Delivery",
                    "Delivered",
                    "Cancelled"
            );

            request.setAttribute("orders", orders);
            request.setAttribute("statuses", statuses);

            RequestDispatcher dispatcher =
                    request.getRequestDispatcher("admin/view-orders.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error retrieving orders.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        try {
            OrderDAO orderDao = new OrderDAO();
            orderDao.updateOrderStatus(orderId, status);

            response.sendRedirect("ViewOrdersServlet");

        } catch (SQLException e) {
            throw new ServletException("Error updating order status.", e);
        }
    }
}