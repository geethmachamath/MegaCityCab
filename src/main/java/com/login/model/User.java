package com.login.model;

import java.io.Serializable;

public class User implements Serializable {
    private String name;
    private String address;
    private String nic;
    private String email;
    private String password;

    // Constructor
    public User(String name, String address, String nic, String email, String password) {
        this.name = name;
        this.address = address;
        this.nic = nic;
        this.email = email;
        this.password = password;
    }

    // Getters
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getNic() { return nic; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    // Setters (ADDED)
    public void setName(String name) { this.name = name; }
    public void setAddress(String address) { this.address = address; }
    public void setNic(String nic) { this.nic = nic; }
}
