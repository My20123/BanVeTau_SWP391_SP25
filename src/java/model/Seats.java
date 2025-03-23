/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Seats {
    private int id,status,seatNo, price;
    private String cabinid,trid;
   

    public Seats() {
    }

    public Seats(int id, int status, int seatNo, int price, String cabinid) {
        this.id = id;
        this.status = status;// 0 là available, 1 là buying, 2 là bought
        this.seatNo = seatNo;
        this.price = price;
        this.cabinid = cabinid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSeatNo() {
        return seatNo;
    }

    public void setSeatNo(int seatNo) {
        this.seatNo = seatNo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getCabinid() {
        return cabinid;
    }

    public void setCabinid(String cabinid) {
        this.cabinid = cabinid;
    }

    public String getTrid() {
        return trid;
    }

    public void setTrid(String trid) {
        this.trid = trid;
    }

    @Override
    public String toString() {
        return "Seats{" + "id=" + id + ", status=" + status + ", seatNo=" + seatNo + ", price=" + price + ", cabinid=" + cabinid + '}';
    }

   
}
