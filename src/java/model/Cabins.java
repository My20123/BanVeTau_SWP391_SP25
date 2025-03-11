/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author tra my
 */
public class Cabins {
    private String id;
    private int number_seats,status,avail_seats;
    private String trid,ctype;
    private int sid;
    private boolean selected,chonChoTuDong;

    public Cabins() {
    }

    public Cabins(String id, int number_seats, int status, int avail_seats, String trid, String ctype,int sid) {
        this.id = id;
        this.number_seats = number_seats;
        this.status = status;//0 la full, 1 la available, 2 la sold out
        this.avail_seats = avail_seats;
        this.trid = trid;
        this.ctype = ctype;
        this.sid=sid;
    }

   

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getNumber_seats() {
        return number_seats;
    }

    public void setNumber_seat(int number_seat) {
        this.number_seats = number_seat;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTrid() {
        return trid;
    }

    public void setTrid(String trid) {
        this.trid = trid;
    }

    public String getCtype() {
        return ctype;
    }

    public void setCtype(String ctype) {
        this.ctype = ctype;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public boolean isChonChoTuDong() {
        return chonChoTuDong;
    }

    public void setChonChoTuDong(boolean chonChoTuDong) {
        this.chonChoTuDong = chonChoTuDong;
    }

    public int getAvail_seats() {
        return avail_seats;
    }

    public void setAvail_seats(int avail_seats) {
        this.avail_seats = avail_seats;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    @Override
    public String toString() {
        return "Cabins{" + "id=" + id + ", number_seats=" + number_seats + ", status=" + status + ", avail_seats=" + avail_seats + ", trid=" + trid + ", ctype=" + ctype + ", selected=" + selected + ", chonChoTuDong=" + chonChoTuDong + '}';
    }

    
    
}
