/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import model.*;

/**
 *
 * @author tra my
 */
public class DAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Accounts> getAllAccounts() {
        List<Accounts> list = new ArrayList<>();
        String query = "select * from accounts";
        try {
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Accounts GetUserById(int id) {
        try {
            String query = "SELECT * FROM accounts WHERE uid = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUser(int id, String uname, String uphone, String umail, String cccd, String avatar, int isAdmin, int isStaff) {
        String query = "UPDATE Accounts SET uname = ?, uphone = ?, umail = ?, cccd = ?, avatar = ?, isAdmin = ?, isStaff = ? WHERE uID = ?";

        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, uname);
            ps.setString(2, uphone);
            ps.setString(3, umail);
            ps.setString(4, cccd);
            ps.setString(5, avatar);
            ps.setInt(6, isAdmin);
            ps.setInt(7, isStaff);
            ps.setInt(8, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStatus(int id) {
        String query = "UPDATE Accounts SET status = NOT status WHERE uID = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List getAllStations() {
        List<String> list = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT route_key FROM routes_data;";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("route_key"));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List getAllRoutes() {
        List<Routes> routes = new ArrayList<>();
        List<Integer> listid = new ArrayList<>();

        try {
            String query = "SELECT * FROM routes";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String query1 = "select * from routes_data where id=?";
                PreparedStatement ps1 = con.prepareStatement(query1);
                ps1.setInt(1, id);
                ResultSet rs1 = ps1.executeQuery();
                LinkedHashMap< String, Integer> thr_stations = new LinkedHashMap<>();

                while (rs1.next()) {
                    thr_stations.put(rs1.getString("route_key"), rs1.getInt("value"));
                }
                routes.add(new Routes(id, rs.getString("from_station"), rs.getString("to_station"), thr_stations));
            }

        } catch (Exception e) {
        }

        return routes;
    }

    public List getAllTrains() {
        List<Trains> list = new ArrayList<>();
        try {

            String query = "SELECT * FROM Trains;";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Trains(rs.getString(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addTrain(Trains train) throws Exception {
        try {
            String query = "INSERT INTO Trains (id, status, number_seat, number_cabin) VALUES (?, ?, ?, ?)";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, train.getTid());
            ps.setInt(2, train.getStatus());
            ps.setInt(3, train.getNumber_seats());
            ps.setInt(4, train.getNumber_cabins());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Trains GetTrainById(String id) {
        try {
            String query = "SELECT * FROM trains WHERE id = ?";
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Trains(rs.getString(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateTrain(String id, int status, int number_seat, int number_cabin) {
        String query = "UPDATE trains SET status = ?, number_seat = ?, number_cabin = ? WHERE id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, status);
            ps.setInt(2, number_seat);
            ps.setInt(3, number_cabin);
            ps.setString(4, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteTrain(String id) {
        String query = "DELETE FROM Trains WHERE id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Accounts login(String user, String pass) {
        try {
            String query = "select * from accounts where uname = ? and pass =?";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public List searchRoute(String depart, String desti) {
        List<Routes> list = new ArrayList<>();
        try {
            String query = "select id,from_station, to_station  from routes where id in(SELECT rd1.id FROM routes_data rd1 JOIN routes_data rd2 ON rd1.id = rd2.id WHERE rd1.route_key = ?  AND rd1.value < rd2.value AND rd2.route_key = ?)";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, depart);
            ps.setString(2, desti);
            rs = ps.executeQuery();

            while (rs.next()) {
                int rid = rs.getInt(1);
                String from_station = rs.getString(2);
                String to_station = rs.getString(3);
                LinkedHashMap<String, Integer> thr_station = new LinkedHashMap<>();
                String query1 = "select route_key, value from routes_data where id=?";
                PreparedStatement ps1 = con.prepareStatement(query1);
                ps.setInt(1, rid);
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    String route_key = rs1.getString("route_key");
                    int value = rs1.getInt("value");
                    thr_station.put(route_key, value);
                }
                list.add(new Routes(rid, from_station, to_station, thr_station));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Accounts checkAccountExist(String user) {
        String query = "select * from accounts where uname = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, user);

            rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getBoolean(10));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public void singup(String user,String email, String pass,String phone) {
        String query = "INSERT INTO accounts ( uname, umail, pass, uphone , isStaff, isAdmin) VALUES ( ?,?,?,?, 0,0)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2,email );
            ps.setString(3, pass);
            ps.setString(4, phone);
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }

public String searchTrainsWithRid(int rid){
    String trids= "";
    try {
        String query = "SELECT trid FROM schedules where rid = ?;";

            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setInt(1, rid);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.isLast()) {
                    trids += rs.getString(1);
                } else {
                    trids += rs.getString(1) + "-";
                }
            }

        } catch (Exception e) {
        }
        return trids;
    }

    public List<Schedule> searchSchedules(String fromStation, String toStation, Date date) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time " +
                    "FROM schedules s " +
                    "INNER JOIN routes r ON s.rid = r.id " +
                    "INNER JOIN trains t ON s.trid = t.id " +
                    "WHERE r.from_station = ? AND r.to_station = ? " +
                    "AND DATE(s.from_time) = DATE(?)";
        
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, fromStation);
            ps.setString(2, toStation);
            ps.setDate(3, new java.sql.Date(date.getTime()));
            rs = ps.executeQuery();
            
            while(rs.next()) {
                Schedule schedule = new Schedule(
                    rs.getInt("id"),
                    rs.getInt("rid"),
                    rs.getString("trid"),
                    rs.getString("train_type"),
                    rs.getString("from_station"),
                    rs.getString("to_station"),
                    rs.getTimestamp("from_time"),
                    rs.getTimestamp("to_time")
                );
                list.add(schedule);
            }           
        } catch (Exception e) {
            System.out.println("Error in searchSchedules: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time " +
                    "FROM schedules s " +
                    "INNER JOIN routes r ON s.rid = r.id " +
                    "INNER JOIN trains t ON s.trid = t.id";
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();  
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getInt("id"));
                s.setRid(rs.getInt("rid"));
                s.setTrid(rs.getString("trid"));
                s.setTrainType(rs.getString("train_type"));
                s.setFromStation(rs.getString("from_station"));
                s.setToStation(rs.getString("to_station"));
                s.setFromTime(rs.getTimestamp("from_time"));
                s.setToTime(rs.getTimestamp("to_time"));
                list.add(s);
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getAllSchedules: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSchedules() {
        String sql = "SELECT COUNT(*) FROM schedules s " +
                    "INNER JOIN trains t ON s.trid = t.id ";
        
        String trainType = null; //request.getParameter("type");
        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ?";
        }
        
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            
            if (trainType != null && !trainType.isEmpty()) {
                st.setString(1, trainType);
            }
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getTotalSchedules: " + e.getMessage());
        }
        return 0;
    }

    public List<Schedule> getSchedulesByPage(int page, int recordsPerPage, String trainType) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time " +
                    "FROM schedules s " +
                    "INNER JOIN routes r ON s.rid = r.id " +
                    "INNER JOIN trains t ON s.trid = t.id ";
        
        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ? ";
        }
        
        sql += "ORDER BY s.from_time ASC LIMIT ? OFFSET ?";
        
        try {
            con = new DBContext().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            
            int paramIndex = 1;
            if (trainType != null && !trainType.isEmpty()) {
                st.setString(paramIndex++, trainType);
            }
            st.setInt(paramIndex++, recordsPerPage);
            st.setInt(paramIndex, (page - 1) * recordsPerPage);
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Schedule s = new Schedule();
                s.setId(rs.getInt("id"));
                s.setRid(rs.getInt("rid"));
                s.setTrid(rs.getString("trid"));
                s.setTrainType(rs.getString("train_type"));
                s.setFromStation(rs.getString("from_station"));
                s.setToStation(rs.getString("to_station"));
                s.setFromTime(rs.getTimestamp("from_time"));
                s.setToTime(rs.getTimestamp("to_time"));
                list.add(s);
            }
            
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Error in getSchedulesByPage: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) throws ParseException, Exception {
        DAO dao = new DAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse("2024-02-28");
        List<Schedule> list = dao.searchSchedules("Hà Nội", "Sài Gòn", date);
        for (Schedule schedule : list) {
            System.out.println(schedule);
        }
    }
}
