package model;

import java.sql.Timestamp;
import java.util.Date;

public class Schedule {
    private int id;
    private int rid;
    private String trid;
    private String trainType;
    private String fromStation;
    private String toStation;
    private Timestamp fromTime;
    private Timestamp toTime;

    public Schedule() {
    }

    public Schedule(int id, int rid, String trid, String trainType, String fromStation, String toStation, Timestamp fromTime, Timestamp toTime) {
        this.id = id;
        this.rid = rid;
        this.trid = trid;
        this.trainType = trainType;
        this.fromStation = fromStation;
        this.toStation = toStation;
        this.fromTime = fromTime;
        this.toTime = toTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public String getTrid() {
        return trid;
    }

    public void setTrid(String trid) {
        this.trid = trid;
    }

    public String getTrainType() {
        return trainType;
    }

    public void setTrainType(String trainType) {
        this.trainType = trainType;
    }

    public String getFromStation() {
        return fromStation;
    }

    public void setFromStation(String fromStation) {
        this.fromStation = fromStation;
    }

    public String getToStation() {
        return toStation;
    }

    public void setToStation(String toStation) {
        this.toStation = toStation;
    }

    public Timestamp getFromTime() {
        return fromTime;
    }

    public void setFromTime(Timestamp fromTime) {
        this.fromTime = fromTime;
    }

    public Timestamp getToTime() {
        return toTime;
    }

    public void setToTime(Timestamp toTime) {
        this.toTime = toTime;
    }

    @Override
    public String toString() {
        return "Schedule{" + "id=" + id + ", rid=" + rid + ", trid=" + trid + 
               ", trainType=" + trainType + ", fromStation=" + fromStation + 
               ", toStation=" + toStation + ", fromTime=" + fromTime + 
               ", toTime=" + toTime + '}';
    }
}
