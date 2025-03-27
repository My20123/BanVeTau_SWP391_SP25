package model;

public class TicketUser {
    private int id;
    private String fullname;
    private String cccd;
    private int ticketId;

    public TicketUser() {
    }

    public TicketUser(int id, String fullname, String cccd, int ticketId) {
        this.id = id;
        this.fullname = fullname;
        this.cccd = cccd;
        this.ticketId = ticketId;
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

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
}