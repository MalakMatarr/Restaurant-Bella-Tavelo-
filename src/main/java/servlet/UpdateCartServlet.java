package servlet;

import model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/UpdateCart")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int foodId = Integer.parseInt(request.getParameter("foodId"));
                int newQuantity = Integer.parseInt(request.getParameter("quantity"));

                for (CartItem item : cart) {
                    if (item.getFoodId() == foodId) {
                        if (newQuantity <= 0) {
                            cart.remove(item);
                        } else {
                            item.setQuantity(newQuantity);
                        }
                        break;
                    }
                }
                session.setAttribute("cart", cart);
            } catch (NumberFormatException ignored) {
            }
        }

        response.sendRedirect("cart.jsp");
    }
}
