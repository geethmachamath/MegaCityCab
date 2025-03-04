package com.login.model;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private String name;
    private String phone;
    private String pickup;
    private String dropLocation;
    private int kms;
    private int cabId;
    private String status;
    private double totalAmount;
    private Timestamp bookedDate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPickup() { return pickup; }
    public void setPickup(String pickup) { this.pickup = pickup; }

    public String getDropLocation() { return dropLocation; }
    public void setDropLocation(String dropLocation) { this.dropLocation = dropLocation; }

    public int getKms() { return kms; }
    public void setKms(int kms) { this.kms = kms; }

    public int getCabId() { return cabId; }
    public void setCabId(int cabId) { this.cabId = cabId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public Timestamp getBookedDate() { return bookedDate; }
    public void setBookedDate(Timestamp bookedDate) { this.bookedDate = bookedDate; }
}