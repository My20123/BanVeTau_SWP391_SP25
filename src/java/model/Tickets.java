/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author tra my
 */
public class Tickets {
    private int id;
    private String from_station,to_station;
    private LocalDateTime from_time,to_time;
    private int ttype; //1 là 1 chiều; 2 là khứ hồi
    private String trid;
    private int sid,rid;
    private String cbid;
    private String tcode;

    public String getTcode() {
        return tcode;
    }

    public void setTcode(String tcode) {
        this.tcode = tcode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFrom_station() {
        return from_station;
    }

    public void setFrom_station(String from_station) {
        this.from_station = from_station;
    }

    public String getTo_station() {
        return to_station;
    }

    public void setTo_station(String to_station) {
        this.to_station = to_station;
    }

    public LocalDateTime getFrom_time() {
        return from_time;
    }

    public void setFrom_time(LocalDateTime from_time) {
        this.from_time = from_time;
    }

    public LocalDateTime getTo_time() {
        return to_time;
    }

    public void setTo_time(LocalDateTime to_time) {
        this.to_time = to_time;
    }

    public int getTtype() {
        return ttype;
    }

    public void setTtype(int ttype) {
        this.ttype = ttype;
    }

    public String getTrid() {
        return trid;
    }

    public void setTrid(String trid) {
        this.trid = trid;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getCbid() {
        return cbid;
    }

    public void setCbid(String cbid) {
        this.cbid = cbid;
    }

    public Tickets(int id, String from_station, String to_station, LocalDateTime from_time, LocalDateTime to_time, int ttype, String trid, int sid, int rid, String cbid) {
        this.id = id;
        this.from_station = from_station;
        this.to_station = to_station;
        this.from_time = from_time;
        this.to_time = to_time;
        this.ttype = ttype;
        this.trid = trid;
        this.sid = sid;
        this.rid = rid;
        this.cbid = cbid;
    }

    public Tickets() {
    }
    
}
