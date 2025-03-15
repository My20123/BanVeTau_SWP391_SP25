/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Set;

/**
 *
 * @author tra my
 */
public class Routes {
    private int id;
    private String from_station, to_station;
    private LinkedHashMap<String,Integer> thr_station;
    
   

    @Override
    public String toString() {
        return "Routes{" + "id=" + id + ", from_station=" + from_station + ", to_station=" + to_station + ", thr_station=" + thr_station + '}';
    }

    public Routes() {
    }

    public Routes(int id, String from_station, String to_station, LinkedHashMap<String, Integer> thr_station) {
        this.id = id;
        this.from_station = from_station;
        this.to_station = to_station;
        this.thr_station = thr_station;
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

    public HashMap<String, Integer> getThr_station() {
        return thr_station;
    }

    public void setThr_station(LinkedHashMap<String, Integer> thr_station) {
        this.thr_station = thr_station;
    }
    
    
    
}
