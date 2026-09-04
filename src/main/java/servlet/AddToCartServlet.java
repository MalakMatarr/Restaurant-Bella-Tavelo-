package servlet;

import model.CartItem;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/AddToCart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("MenuServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        HttpSession session = request.getSession();

        if (session.getAttribute("user") == null) {
            session.setAttribute("redirectAfterLogin", "menu.jsp");
            if (isAjax) {
                
                writeJson(response, HttpServletResponse.SC_UNAUTHORIZED,
                        "{\"success\":false,\"redirect\":\"login.html?message=Please log in to place an order\"}");
            } else {
                response.sendRedirect("login.html?message=Please log in to place an order");
            }
            return;
        }

        try {
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            String foodName = request.getParameter("foodName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String[] selectedAddons = request.getParameterValues("addons"); // e.g. "Extra Cheese:2.00"
            String addonsLabel = "";
            double addonsPrice = 0.0;

            if (selectedAddons != null) {
                StringBuilder labelBuilder = new StringBuilder();
                for (String addon : selectedAddons) {
                    String[] parts = addon.split(":");
                    if (labelBuilder.length() > 0) {
                        labelBuilder.append(", ");
                    }
                    labelBuilder.append(parts[0]);
                    if (parts.length > 1) {
                        addonsPrice += Double.parseDouble(parts[1]);
                    }
                }
                addonsLabel = labelBuilder.toString();
            }

            if (quantity < 1) {
                quantity = 1;
            }

            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            boolean merged = false;
            for (CartItem item : cart) {
                if (item.getFoodId() == foodId && item.getAddons().equals(addonsLabel)) {
                    item.setQuantity(item.getQuantity() + quantity);
                    merged = true;
                    break;
                }
            }
            if (!merged) {
                cart.add(new CartItem(foodId, foodName, price, quantity, addonsLabel, addonsPrice));
            }

            session.setAttribute("cart", cart);

            if (isAjax) {
                int cartCount = 0;
                for (CartItem item : cart) {
                    cartCount += item.getQuantity();
                }
                writeJson(response, HttpServletResponse.SC_OK,
                        "{\"success\":true,\"foodName\":\"" + escapeJson(foodName) + "\",\"cartCount\":" + cartCount + "}");
            } else {
                response.sendRedirect("cart.jsp?added=1");
            }

        } catch (NumberFormatException e) {
            if (isAjax) {
                writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                        "{\"success\":false,\"message\":\"Invalid item selection. Please try again.\"}");
            } else {
                request.setAttribute("errorMessage", "Invalid item selection. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("MenuServlet");
                dispatcher.forward(request, response);
            }
        }
    }

    private void writeJson(HttpServletResponse response, int status, String json) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }

    private String escapeJson(String value) {
        return value == null ? "" : value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}