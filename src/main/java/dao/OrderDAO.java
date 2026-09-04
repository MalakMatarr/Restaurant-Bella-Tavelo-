package dao;

import model.Order;
import model.OrderItem;
import model.Transaction;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int placeOrder(Order order, Transaction transaction) throws SQLException {
        String insertOrderSql =
                "INSERT INTO orders (user_id, created_at, status, total_price, payment_method, delivery_address, contact_phone) "
              + "VALUES (?, NOW(), ?, ?, ?, ?, ?)";

        String insertItemSql =
                "INSERT INTO order_items (order_id, item_id, food_name, quantity, addons, price, subtotal) "
              + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertTxnSql =
                "INSERT INTO transactions (order_id, payment_status, payment_date, amount, payment_method) "
              + "VALUES (?, ?, NOW(), ?, ?)";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            int orderId;
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUserId());
                ps.setString(2, order.getStatus());
                ps.setDouble(3, order.getTotalAmount());
                ps.setString(4, order.getPaymentMethod());
                ps.setString(5, order.getDeliveryAddress());
                ps.setString(6, order.getContactPhone());
                ps.executeUpdate();

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        orderId = keys.getInt(1);
                    } else {
                        throw new SQLException("Failed to obtain generated order_id.");
                    }
                }
            }

            try (PreparedStatement ps = conn.prepareStatement(insertItemSql)) {
                for (OrderItem item : order.getItems()) {
                    ps.setInt(1, orderId);
                    ps.setInt(2, item.getFoodId());
                    ps.setString(3, item.getFoodName());
                    ps.setInt(4, item.getQuantity());
                    ps.setString(5, item.getAddons());
                    ps.setDouble(6, item.getItemPrice());
                    ps.setDouble(7, item.getItemPrice() * item.getQuantity());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            try (PreparedStatement ps = conn.prepareStatement(insertTxnSql)) {
                ps.setInt(1, orderId);
                ps.setString(2, transaction.getPaymentStatus());
                ps.setDouble(3, transaction.getAmount());
                ps.setString(4, transaction.getPaymentMethod());
                ps.executeUpdate();
            }

            conn.commit();
            return orderId;

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public Order getOrderById(int orderId) throws SQLException {
        String orderSql = "SELECT * FROM orders WHERE order_id = ?";
        String itemsSql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            Order order = null;
            try (PreparedStatement ps = conn.prepareStatement(orderSql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        order = mapOrder(rs);
                    }
                }
            }
            if (order == null) {
                return null;
            }
            try (PreparedStatement ps = conn.prepareStatement(itemsSql)) {
                ps.setInt(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        order.addItem(mapOrderItem(rs));
                    }
                }
            }
            return order;
        }
    }

    public List<Order> getOrdersByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(mapOrder(rs));
                }
            }
        }
        
        for (Order order : orders) {
            String itemsSql = "SELECT * FROM order_items WHERE order_id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(itemsSql)) {
                ps.setInt(1, order.getOrderId());
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        order.addItem(mapOrderItem(rs));
                    }
                }
            }
        }
        return orders;
    }

    public List<Order> getAllOrders() throws SQLException {
        String sql = "SELECT o.*, u.full_name AS customer_name "
                   + "FROM orders o "
                   + "JOIN users u ON o.user_id = u.id "
                   + "ORDER BY o.created_at DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Order order = mapOrder(rs);
                order.setCustomerName(rs.getString("customer_name"));
                orders.add(order);
            }
        }

       
        String itemsSql = "SELECT food_name, quantity, addons FROM order_items WHERE order_id = ? ORDER BY order_item_id";
        for (Order order : orders) {
            StringBuilder summary = new StringBuilder();
            StringBuilder addonsSummary = new StringBuilder();
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(itemsSql)) {
                ps.setInt(1, order.getOrderId());
                try (ResultSet rs = ps.executeQuery()) {
                    boolean first = true;
                    boolean firstAddon = true;
                    while (rs.next()) {
                        if (!first) {
                            summary.append(", ");
                        }
                        String foodName = rs.getString("food_name");
                        summary.append(foodName)
                               .append(" x")
                               .append(rs.getInt("quantity"));
                        first = false;

                        String addons = rs.getString("addons");
                        if (addons != null && !addons.isBlank()) {
                            if (!firstAddon) {
                                addonsSummary.append("; ");
                            }
                            addonsSummary.append(foodName).append(": ").append(addons);
                            firstAddon = false;
                        }
                    }
                }
            }
            order.setItemsSummary(summary.toString());
            order.setAddonsSummary(addonsSummary.length() == 0 ? "-" : addonsSummary.toString());
        }

        return orders;
    }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setOrderDate(rs.getTimestamp("created_at"));
        o.setStatus(rs.getString("status"));
        o.setTotalAmount(rs.getDouble("total_price"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setDeliveryAddress(rs.getString("delivery_address"));
        o.setContactPhone(rs.getString("contact_phone"));
        return o;
    }

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setFoodId(rs.getInt("item_id"));
        item.setFoodName(rs.getString("food_name"));
        item.setQuantity(rs.getInt("quantity"));
        item.setAddons(rs.getString("addons"));
        item.setItemPrice(rs.getDouble("price"));
        item.setSubtotal(rs.getDouble("subtotal"));
        return item;
    }
}