package model;

import java.io.Serializable;


public class CartItem implements Serializable {

    private int foodId;
    private String foodName;
    private double unitPrice;
    private int quantity;
    private String addons;       
    private double addonsPrice;  

    public CartItem() {
    }

    public CartItem(int foodId, String foodName, double unitPrice, int quantity,
                     String addons, double addonsPrice) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.addons = addons;
        this.addonsPrice = addonsPrice;
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

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
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

    public double getAddonsPrice() {
        return addonsPrice;
    }

    public void setAddonsPrice(double addonsPrice) {
        this.addonsPrice = addonsPrice;
    }

    /** Subtotal for this line = (unit price + add-on price) * quantity. */
    public double getSubtotal() {
        return (unitPrice + addonsPrice) * quantity;
    }
}
