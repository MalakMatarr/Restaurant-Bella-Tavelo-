package servlet;

import model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@WebServlet("/RemoveFromCart")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int foodId = Integer.parseInt(request.getParameter("foodId"));
                Iterator<CartItem> it = cart.iterator();
                while (it.hasNext()) {
                    if (it.next().getFoodId() == foodId) {
                        it.remove();
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
