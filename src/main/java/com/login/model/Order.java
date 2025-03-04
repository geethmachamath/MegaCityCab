package com.login.model;

public class Order {
    private int id;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String pickupLocation;
    private String dropLocation;
    private double kms;
    private int cabId;
    private String status;
    private double totalAmount;
    private String bookedDate;
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getCustomerName() {
        return customerName;
    }
    
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    
    public String getCustomerEmail() {
        return customerEmail;
    }
    
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    
    public String getCustomerPhone() {
        return customerPhone;
    }
    
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }
    
    public String getPickupLocation() {
        return pickupLocation;
    }
    
    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }
    
    public String getDropLocation() {
        return dropLocation;
    }
    
    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }
    
    public double getKms() {
        return kms;
    }
    
    public void setKms(double kms) {
        this.kms = kms;
    }
    
    public int getCabId() {
        return cabId;
    }
    
    public void setCabId(int cabId) {
        this.cabId = cabId;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getBookedDate() {
        return bookedDate;
    }
    
    public void setBookedDate(String bookedDate) {
        this.bookedDate = bookedDate;
    }
}