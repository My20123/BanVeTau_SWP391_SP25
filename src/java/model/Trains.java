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
    private String tid, train_type;
    private int status,total_seats,number_cabins,available_seats;

    public Trains() {
    }

    public Trains(String tid, String train_type, int status, int total_seats, int number_cabins, int available_seats) {
        this.tid = tid;
        this.train_type = train_type;
        this.status = status;
        this.total_seats = total_seats;
        this.number_cabins = number_cabins;
        this.available_seats = available_seats;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getTrain_type() {
        return train_type;
    }

    public void setTrain_type(String train_type) {
        this.train_type = train_type;
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
