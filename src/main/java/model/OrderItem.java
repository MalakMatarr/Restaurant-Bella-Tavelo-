package model;

import java.io.Serializable;

public class OrderItem implements Serializable {

    private int orderItemId;
    private int orderId;
    private int foodId;
    private String foodName;   
    private int quantity;
    private String addons;
    private double itemPrice;  
    private double subtotal;

    public OrderItem() {
    }

    public OrderItem(int foodId, String foodName, int quantity, String addons,
                      double itemPrice, double subtotal) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.quantity = quantity;
        this.addons = addons;
        this.itemPrice = itemPrice;
        this.subtotal = subtotal;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getAddons() {
        return addons;
    }

    public void setAddons(String addons) {
        this.addons = addons;
    }

    public double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}
