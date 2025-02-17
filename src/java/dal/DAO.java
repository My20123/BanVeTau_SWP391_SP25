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
        String query = "select * from Accounts";
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
                        rs.getInt(7)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List getAllStations() {
        List<String> list = new ArrayList<>();
        try {
            String query = "SELECT DISTINCT route_key FROM Routes_data;";
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

    public Accounts GetUserById(int id) {
        try {
            String query = "SELECT * FROM Accounts WHERE uID = ?";
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
                        rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateUser(int id, String uname, String uphone, String umail, String role) {
        String query = "UPDATE Accounts SET uname = ?, uphone = ?, umail = ?, role = ? WHERE id = ?";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, uname);
            ps.setString(2, uphone);
            ps.setString(3, umail);
            ps.setString(4, role);
            ps.setInt(5, id);
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
                        rs.getInt(7));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public List searchRoute(String depart, String desti) {
        List<Routes> list = new ArrayList<>();
        try {
            String query = "select id,from_station, to_station  from Routes where id in(SELECT rd1.id FROM Routes_data rd1 JOIN Routes_data rd2 ON rd1.id = rd2.id WHERE rd1.route_key = ?  AND rd1.value < rd2.value AND rd2.route_key = ?)";
            con = new DBContext().getConnection();//mo ket noi voi sql
            ps = con.prepareStatement(query);
            ps.setString(1, depart);
            ps.setString(2, desti);
            rs = ps.executeQuery();

            while (rs.next()) {
                int rid = rs.getInt(1);
                String from_station = rs.getString(2);
                String to_station = rs.getString(3);
                HashMap<String, Integer> thr_station = new HashMap<>();
                String query1 = "select route_key, value from Routes_data where id=1";
                PreparedStatement ps1 = con.prepareStatement(query1);
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
        String query = "select * from accounts where [uname] = ?";
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
                        rs.getInt(7));
            }
        } catch (Exception e) {

        }
        return null;
    }

    public void singup(String user, String pass) {
        String query = "insert into accounts values(?,0,?,0,0,0)";
        try {
            con = new DBContext().getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }
//

    public List searchSchedules(List<Routes> routes, Date date) throws Exception {
        List<Schedules> schedulesList = new ArrayList<>();
        String query = "SELECT id, rid, trid, from_time FROM Schedules WHERE DATE(from_time) = ? AND rid = ?";
        for (Routes route : routes) {
            int routeId = route.getId();
            try (Connection con = new DBContext().getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

                // Set parameters
                stmt.setDate(1, new java.sql.Date(date.getTime()));  // Convert java.util.Date to java.sql.Date
                stmt.setInt(2, routeId);

                // Execute query
                ResultSet rs = stmt.executeQuery();

                // Process the result set
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int rid = rs.getInt("rid");
                    String trid = rs.getString("trid");
                    Date fromTime = rs.getTimestamp("from_time");

                    // Add the result to the list
                    schedulesList.add(new Schedules(id, rid, trid, fromTime));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return schedulesList;
    }

    public static void main(String[] args) throws ParseException, Exception {
        DAO dao = new DAO();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = "2025-02-22";
        Date parsedDate = sdf.parse(dateString);
        List<Schedules> list = dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), parsedDate);
        for (Schedules s : list) {
            System.out.println(s);
        }
//        System.out.println(dao.login("My", "123456"));

//        System.out.println(list);
//List<Accounts> listA = dao.getAllAccounts();
//        for (Routes o : list) {
//            System.out.println(o);
//        }
    }

}
