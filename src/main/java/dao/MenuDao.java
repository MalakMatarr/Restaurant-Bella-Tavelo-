package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Category;
import model.MenuItem;
import util.DBConnection;

public class MenuDao {

    public List<MenuItem> getAllItems() {
        List<MenuItem> items = new ArrayList<>();

        String sql = "SELECT mi.item_id, mi.category_id, c.category_name, mi.name, "
                   + "mi.description, mi.ingredients, mi.nutrition_info, mi.price, "
                   + "mi.image_url, mi.is_available "
                   + "FROM menu_items mi "
                   + "JOIN categories c ON mi.category_id = c.category_id "
                   + "WHERE mi.is_available = TRUE "
                   + "ORDER BY c.category_id, mi.item_id";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
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
                items.add(item);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();

        String sql = "SELECT category_id, category_name, description FROM categories ORDER BY category_id";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category cat = new Category();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                cat.setDescription(rs.getString("description"));
                categories.add(cat);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
