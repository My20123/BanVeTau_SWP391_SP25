package model;

public class OrderUser {
    private int id;
    private String fullname;
    private String cccd;
    private String email;
    private String phone;
    private int orderId;

    public OrderUser() {
    }

    public OrderUser(int id, String fullname, String cccd, String email, String phone, int orderId) {
        this.id = id;
        this.fullname = fullname;
        this.cccd = cccd;
        this.email = email;
        this.phone = phone;
        this.orderId = orderId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
}