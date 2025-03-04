package com.login.model;

public class Employee {
    private String name;
    private String email;
    private String password;
    private String type;

    public Employee(String name, String email, String password, String type) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.type = type;
    }

    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getType() { return type; }
}
