package servlet;

import dao.OrderDAO;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.Transaction;

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
import model.User;;

@WebServlet("/Checkout")
public class CheckoutServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
        	response.sendRedirect("login.html?message=Please log in to checkout");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
        	response.sendRedirect("cart.jsp?cartEmpty=1");
            return;
        }

        double total = 0.0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }

        request.setAttribute("cart", cart);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.html?message=Please log in to checkout");
            return;
        }

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
        	response.sendRedirect("cart.jsp?cartEmpty=1");
            return;
        }

        String deliveryAddress = trim(request.getParameter("deliveryAddress"));
        String contactPhone = trim(request.getParameter("contactPhone"));
        String paymentMethod = trim(request.getParameter("paymentMethod"));

        String validationError = validate(deliveryAddress, contactPhone, paymentMethod);
        if (validationError != null) {
            double total = 0.0;
            for (CartItem item : cart) {
                total += item.getSubtotal();
            }
            request.setAttribute("cart", cart);
            request.setAttribute("cartTotal", total);
            request.setAttribute("errorMessage", validationError);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        Order order = new Order();
        order.setUserId(userId);
        order.setStatus("COD".equals(paymentMethod) ? "PENDING" : "PAID");
        order.setPaymentMethod(paymentMethod);
        order.setDeliveryAddress(deliveryAddress);
        order.setContactPhone(contactPhone);

        double total = 0.0;
        for (CartItem cartItem : cart) {
            OrderItem orderItem = new OrderItem(
                    cartItem.getFoodId(),
                    cartItem.getFoodName(),
                    cartItem.getQuantity(),
                    cartItem.getAddons(),
                    cartItem.getUnitPrice() + cartItem.getAddonsPrice(),
                    cartItem.getSubtotal()
            );
            order.addItem(orderItem);
            total += cartItem.getSubtotal();
        }
        order.setTotalAmount(total);

        Transaction transaction = new Transaction(
                0,
                "COD".equals(paymentMethod) ? "PENDING" : "SUCCESS",
                total,
                paymentMethod
        );

        try {
            int orderId = orderDAO.placeOrder(order, transaction);

            session.removeAttribute("cart");

            response.sendRedirect("OrderConfirmation?orderId=" + orderId);

        } catch (SQLException e) {
        	e.printStackTrace();
            request.setAttribute("cart", cart);
            request.setAttribute("cartTotal", total);
            request.setAttribute("errorMessage",
                    "We could not process your order due to a system error. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
            dispatcher.forward(request, response);
        }
    }

    private String validate(String deliveryAddress, String contactPhone, String paymentMethod) {
        if (deliveryAddress == null || deliveryAddress.length() < 10) {
            return "Please enter a complete delivery address (at least 10 characters).";
        }
        if (contactPhone == null || !contactPhone.matches("^[0-9+\\-\\s]{9,15}$")) {
            return "Please enter a valid contact phone number.";
        }
        if (paymentMethod == null
                || !(paymentMethod.equals("COD")
                     || paymentMethod.equals("CARD")
                     || paymentMethod.equals("ONLINE_BANKING"))) {
            return "Please select a valid payment method.";
        }
        return null;
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}
