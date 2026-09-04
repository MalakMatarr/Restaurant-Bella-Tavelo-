package model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Transaction implements Serializable {

    private int transactionId;
    private int orderId;
    private String paymentStatus;  
    private Timestamp paymentDate;
    private double amount;
    private String paymentMethod;

    public Transaction() {
    }

    public Transaction(int orderId, String paymentStatus, double amount, String paymentMethod) {
        this.orderId = orderId;
        this.paymentStatus = paymentStatus;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
