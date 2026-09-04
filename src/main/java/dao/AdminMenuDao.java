package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.MenuItem;
import util.DBConnection;

public class AdminMenuDao {

    public List<MenuItem> getAllItemsForAdmin() {
        List<MenuItem> items = new ArrayList<>();

        String sql = "SELECT mi.item_id, mi.category_id, c.category_name, mi.name, "
                   + "mi.description, mi.ingredients, mi.nutrition_info, mi.price, "
                   + "mi.image_url, mi.is_available "
                   + "FROM menu_items mi "
                   + "JOIN categories c ON mi.category_id = c.category_id "
                   + "ORDER BY c.category_id, mi.item_id";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapRow(rs));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public MenuItem getItemById(int itemId) {
        MenuItem item = null;

        String sql = "SELECT mi.item_id, mi.category_id, c.category_name, mi.name, "
                   + "mi.description, mi.ingredients, mi.nutrition_info, mi.price, "
                   + "mi.image_url, mi.is_available "
                   + "FROM menu_items mi "
                   + "JOIN categories c ON mi.category_id = c.category_id "
                   + "WHERE mi.item_id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, itemId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                item = mapRow(rs);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return item;
    }

    public boolean addItem(MenuItem item) {

        String sql = "INSERT INTO menu_items "
                   + "(category_id, name, description, ingredients, nutrition_info, price, image_url, is_available) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, item.getCategoryId());
            ps.setString(2, item.getName());
            ps.setString(3, item.getDescription());
            ps.setString(4, item.getIngredients());
            ps.setString(5, item.getNutritionInfo());
            ps.setDouble(6, item.getPrice());
            ps.setString(7, item.getImageUrl());
            ps.setBoolean(8, item.isAvailable());

            int rows = ps.executeUpdate();

            ps.close();
            conn.close();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateItem(MenuItem item) {

        String sql = "UPDATE menu_items SET category_id = ?, name = ?, description = ?, "
                   + "ingredients = ?, nutrition_info = ?, price = ?, image_url = ?, is_available = ? "
                   + "WHERE item_id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, item.getCategoryId());
            ps.setString(2, item.getName());
            ps.setString(3, item.getDescription());
            ps.setString(4, item.getIngredients());
            ps.setString(5, item.getNutritionInfo());
            ps.setDouble(6, item.getPrice());
            ps.setString(7, item.getImageUrl());
            ps.setBoolean(8, item.isAvailable());
            ps.setInt(9, item.getItemId());

            int rows = ps.executeUpdate();

            ps.close();
            conn.close();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteItem(int itemId) {

        String sql = "DELETE FROM menu_items WHERE item_id = ?";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, itemId);

            int rows = ps.executeUpdate();

            ps.close();
            conn.close();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    private MenuItem mapRow(ResultSet rs) throws SQLException {
        MenuItem item = new MenuItem();
        item.setItemId(rs.getInt("item_id"));
        item.setCategoryId(rs.getInt("category_id"));
        item.setCategoryName(rs.getString("category_name"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setIngredients(rs.getString("ingredients"));
        item.setNutritionInfo(rs.getString("nutrition_info"));
        item.setPrice(rs.getDouble("price"));
        item.setImageUrl(rs.getString("image_url"));
        item.setAvailable(rs.getBoolean("is_available"));
        return item;
    }
}
