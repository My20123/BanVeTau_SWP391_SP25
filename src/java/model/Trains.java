/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tra my
 */
public class Trains {
    private String tid;
    private int status,total_seats,number_cabins,available_seats;

    public Trains() {
    }

    public Trains(String tid, int status, int number_seats, int number_cabins) {
        this.tid = tid;
        this.status = status;
        this.total_seats = number_seats;
        this.number_cabins = number_cabins;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getTotal_seats() {
        return total_seats;
    }

    public void setTotal_seats(int total_seats) {
        this.total_seats = total_seats;
    }

    public int getNumber_cabins() {
        return number_cabins;
    }

    public void setNumber_cabins(int number_cabins) {
        this.number_cabins = number_cabins;
    }

    public int getAvailable_seats() {
        return available_seats;
    }

    public void setAvailable_seats(int available_seats) {
        this.available_seats = available_seats;
    }
    
    
}
