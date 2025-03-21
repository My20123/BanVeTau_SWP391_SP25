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
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.*;

/**
 *
 * @author tra my
 */
public class DAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public DAO() {
        try {
            conn = new DBContext().getConnection();
        } catch (Exception e) {
            System.out.println("Error connecting to database: " + e.getMessage());
        }
    }

    public List<Accounts> getAllAccounts() {
        List<Accounts> list = new ArrayList<>();
        String query = "select * from accounts";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
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
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
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
            PreparedStatement ps = conn.prepareStatement(query);
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
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List getAllStations() {
        List<String> list = new ArrayList<>();
        try {

            String query = "SELECT DISTINCT from_station FROM Routes UNION SELECT DISTINCT to_station FROM Routes ORDER BY from_station;";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the error instead of silently ignoring it
        }
        return list;
    }

    public List getAllRoutes() {
        List<Routes> routes = new ArrayList<>();
        List<Integer> listid = new ArrayList<>();

        try {

            String query = "SELECT * FROM Routes";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String query1 = "select * from Routes_data where id=?";
                PreparedStatement ps1 = conn.prepareStatement(query1);

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
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Trains(rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Cabins> getAllCabins() {
        List<Cabins> list = new ArrayList<>();
        String query = "select * from cabins";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cabins(rs.getString(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public void addCabin(Cabins ca) throws Exception {
        try {
            String query = "INSERT INTO Cabins (id, number_seat, status, avail_seat, trid, ctype, sid) VALUES (?, ?, ?, ?, ?, ?, ?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ca.getId());
            ps.setInt(2, ca.getNumber_seats());
            ps.setInt(3, ca.getStatus());
            ps.setInt(4, ca.getAvail_seats());
            ps.setString(5, ca.getTrid());
            ps.setString(6, ca.getCtype());
            ps.setInt(7, ca.getSid());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public Cabins GetCabinById(String id) {
        try {
            String query = "SELECT * FROM cabins WHERE id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Cabins(rs.getString(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCabin(String id, int number_seat, int status, int avail_seat, String trid, String ctype, int sid) {
        String query = "UPDATE cabins SET number_seat = ?, status = ?, avail_seat = ?, trid = ?, ctype = ?, sid WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, number_seat);
            ps.setInt(2, status);
            ps.setInt(3, avail_seat);
            ps.setString(4, trid);
            ps.setString(5, ctype);
            ps.setInt(6,sid);                 
            ps.setString(7, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    

    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time "
                + "FROM schedules s "
                + "INNER JOIN routes r ON s.rid = r.id "
                + "INNER JOIN trains t ON s.trid = t.id";
        try {
            conn = new DBContext().getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
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
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getAllSchedules: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSchedules() {
        String sql = "SELECT COUNT(*) FROM schedules s "
                + "INNER JOIN trains t ON s.trid = t.id ";

        String trainType = null; //request.getParameter("type");
        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ?";
        }

        try {
            conn = new DBContext().getConnection();
            PreparedStatement st = conn.prepareStatement(sql);

            if (trainType != null && !trainType.isEmpty()) {
                st.setString(1, trainType);
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

            rs.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getTotalSchedules: " + e.getMessage());
        }
        return 0;
    }

    public List<Schedule> getSchedulesByPage(int page, int recordsPerPage, String trainType) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time "
                + "FROM schedules s "
                + "INNER JOIN routes r ON s.rid = r.id "
                + "INNER JOIN trains t ON s.trid = t.id ";

        if (trainType != null && !trainType.isEmpty()) {
            sql += "WHERE t.train_type = ? ";
        }

        sql += "ORDER BY s.from_time ASC LIMIT ? OFFSET ?";

        try {
            conn = new DBContext().getConnection();
            PreparedStatement st = conn.prepareStatement(sql);

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
            conn.close();
        } catch (Exception e) {
            System.out.println("Error in getSchedulesByPage: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public List getSeatsWithCabinId(String cbid) {
        List<Seats> list = new ArrayList();
        try {
            String query = "SELECT * FROM Seats where cbid = ?;";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, cbid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Seats(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), cbid));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Seats get1SeatWithCabinIdNSeatN0(String cbid, int seatNo) {
        try {
            String query = "SELECT * FROM Seats where cbid = ? and seatNo = ?;";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, cbid);
            ps.setInt(2, seatNo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Seats(rs.getInt(1), rs.getInt(3), seatNo, rs.getInt(4), cbid);
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List getCabinsWithTrainIDNScheduleID(String trid, int sid) {
        List<Cabins> list = new ArrayList();
        try {
            String query = "SELECT * FROM Cabins where trid = ? and sid=?;";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, trid);
            ps.setInt(2, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cabins(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), trid, rs.getString(6), sid));
            }
        } catch (Exception e) {
        }
        list.sort(Comparator.comparing(cabin -> {
            String[] parts = cabin.getId().split("/");
            return Integer.parseInt(parts[1]); // Chỉ lấy số và chuyển về kiểu Integer để sắp xếp
        }));
        return list;
    }

    public void addTrain(Trains train) throws Exception {
        try {
            String query = "INSERT INTO Trains (id, train_type, status, number_seat, number_cabin, avail_seats) VALUES (?, ?, ?, ?, ?, ?)";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, train.getTid());
            ps.setString(2, train.getTrain_type());
            ps.setInt(3, train.getStatus());
            ps.setInt(4, train.getTotal_seats());
            ps.setInt(5, train.getNumber_cabins());
            ps.setInt(6, train.getAvailable_seats());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Trains GetTrainById(String id) {
        try {
            String query = "SELECT * FROM trains WHERE id = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Trains(rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateTrain(String id, String type, int status, int number_seat, int number_cabin, int avail_seats) {
        String query = "UPDATE trains SET train_type = ?, status = ?, number_seat = ?, number_cabin = ?, avail_seats = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, type);
            ps.setInt(2, status);
            ps.setInt(3, number_seat);
            ps.setInt(4, number_cabin);
            ps.setInt(5, avail_seats);
            ps.setString(6, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteTrain(String id) {
        String query = "DELETE FROM Trains WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public Accounts login(String user, String pass) {
        try {
            String query = "select * from accounts where uname = ? and pass =?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
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

            String query = "select id,from_station, to_station  from Routes where id in(SELECT rd1.id FROM Routes_data rd1 JOIN Routes_data rd2 ON rd1.id = rd2.id WHERE rd1.route_key = ?  AND rd1.value < rd2.value AND rd2.route_key = ?)";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, depart);
            ps.setString(2, desti);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int rid = rs.getInt(1);
                String from_station = rs.getString(2);
                String to_station = rs.getString(3);
                LinkedHashMap<String, Integer> thr_station = new LinkedHashMap<>();

                String query1 = "select route_key, value from Routes_data where id=?";
                PreparedStatement ps1 = conn.prepareStatement(query1);
                ps1.setInt(1, rid);

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
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);

            ResultSet rs = ps.executeQuery();
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

    public void singup(String user, String email, String pass, String phone) {
        String query = "INSERT INTO Accounts ( uname, umail, pass, uphone , isStaff, isAdmin) VALUES ( ?,?,?,?, 0,0)";

        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, phone);
            ps.executeUpdate();
        } catch (Exception e) {

        }
    }

    public String searchTrainIDWithRid(int rid) {
        String trids = "";
        try {
            String query = "SELECT trid FROM Schedules where rid = ?;";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
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

    public int searchAvailSeatsOfTrainWithScheduleID(int sid) {
        int avail_seats;
        try {
            String query = "SELECT trid FROM Schedules where id = ?;";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String trid = rs.getString(1);
                String query1 = "SELECT avail_seats FROM Trains where id = ?;";
                PreparedStatement ps1 = conn.prepareStatement(query1);
                ps1.setString(1, trid);
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    avail_seats = rs1.getInt(1);
                    return avail_seats;
                }
            }

        } catch (Exception e) {
        }
        return 0;
    }

    public int searchAvailSeatsOfCabinWithCabinID(String cid) {
        int avail_seats = 0;
        try {
            String query = "SELECT avail_seat FROM Cabins where id = ?;";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                avail_seats = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return avail_seats;
    }

    public List<Cabins> searchCabinsWithTrainID(String trid) {
        List<Cabins> listC = new ArrayList<>();

        String sql = "SELECT * FROM Cabins WHERE trid = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trid);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cabins cabin = new Cabins(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                    listC.add(cabin);
                }
                listC.sort(Comparator.comparingInt(c -> {
                    String[] parts = c.getId().split("/");
                    return (parts.length > 1) ? Integer.parseInt(parts[1]) : 0;
                }));

                return listC;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;

    }

    public List<Schedule> searchSchedules(String fromStation, String toStation, Date date) {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT s.id, s.rid, s.trid, t.train_type, r.from_station, r.to_station, s.from_time, s.to_time "
                + "FROM schedules s "
                + "INNER JOIN routes r ON s.rid = r.id "
                + "INNER JOIN trains t ON s.trid = t.id "
                + "WHERE r.from_station = ? AND r.to_station = ? "
                + "AND DATE(s.from_time) = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, fromStation);
            ps.setString(2, toStation);
            ps.setDate(3, new java.sql.Date(date.getTime()));
            rs = ps.executeQuery();
            while (rs.next()) {
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

    public Schedule searchScheduleWithTridNDate(String trid, Date date) throws Exception {
        String query = "SELECT * FROM Schedules WHERE (Date)from_time = ? AND trid = ?";
        Schedule schedule = new Schedule();

        try (PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set parameters
            stmt.setDate(1, new java.sql.Date(date.getTime()));  // Convert java.util.Date to java.sql.Date
            stmt.setString(2, trid);

            // Execute query
            ResultSet rs = stmt.executeQuery();

            // Process the result set
            while (rs.next()) {
                schedule.setFromTime(new Timestamp(date.getTime()));
                schedule.setId(rs.getInt(1));
                schedule.setRid(rs.getInt(2));
                schedule.setTrid(trid);
                schedule.setFromStation(trid);
                schedule.setToStation(trid);
                schedule.setToTime(new Timestamp(System.currentTimeMillis()));
                schedule.setTrainType("Tàu thường");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return schedule;
    }

    public boolean createBooking(int userId, String scheduleId, String cabinId,
            double totalAmount, String paymentMethod,
            String contactName, String contactEmail, String contactPhone) {
        String sql = "INSERT INTO Booking (user_id, schedule_id, cabin_id, total_amount, "
                + "payment_method, payment_status, contact_name, contact_email, "
                + "contact_phone, booking_time, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, scheduleId);
            st.setString(3, cabinId);
            st.setDouble(4, totalAmount);
            st.setString(5, paymentMethod);
            st.setString(6, "completed"); // Payment status
            st.setString(7, contactName);
            st.setString(8, contactEmail);
            st.setString(9, contactPhone);
            st.setString(10, "confirmed"); // Booking status

            int rowsAffected = st.executeUpdate();

            if (rowsAffected > 0) {
                // Update cabin availability or mark seats as booked
                return updateCabinAvailability(scheduleId, cabinId);
            }
            return false;
        } catch (SQLException e) {
            System.out.println("Error creating booking: " + e.getMessage());
            return false;
        }
    }

    private boolean updateCabinAvailability(String scheduleId, String cabinId) {
        String sql = "UPDATE Cabins SET avail_seat = avail_seat - 1 "
                + "WHERE id = ? AND sid = ? AND avail_seat > 0";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, cabinId);
            st.setString(2, scheduleId);

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating cabin availability: " + e.getMessage());
            return false;
        }
    }

    public int updateSeatsPrice(String fromStation, String toStation, int sid, String cabinType, String cabinId, int seatNo) throws SQLException {
        int seatPrice = 0;
        int price = 0;
        int rid = 0;

        String query = "select rid from Schedules where id=?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rid = rs.getInt(1);

                // ✅ Truy vấn khoảng cách giữa fromStation và toStation
                String query1 = "SELECT ABS("
                        + "    (SELECT value FROM Routes_data WHERE route_key = ? AND id = ?) - "
                        + "    (SELECT value FROM Routes_data WHERE route_key = ? AND id = ?)"
                        + ") AS distance";

                try (PreparedStatement ps1 = conn.prepareStatement(query1)) {
                    ps1.setString(1, toStation);
                    ps1.setInt(2, rid);
                    ps1.setString(3, fromStation);
                    ps1.setInt(4, rid);

                    ResultSet rs1 = ps1.executeQuery();
                    while (rs1.next()) {
                        int distance = rs1.getInt("distance");

                        // ✅ Điều chỉnh giá vé dựa vào loại cabin
                        if (cabinType.contains("n")) {
                            seatPrice += 75000; // Nếu là giường nằm, cộng 250K
                        }

                        if (cabinType.charAt(0) == 'A') {
                            seatPrice += 60000; // Cabin loại A (4 chỗ 1 hàng ngang hoặc 1 khoang nhỏ) cộng 60K
                        } else if (cabinType.charAt(0) == 'B') {
                            seatPrice += 50000; // Cabin loại B (6 chỗ 1 hàng ngang hoặc 1 khoang nhỏ) cộng 50K
                        }

                        int vip = cabinType.contains("v") ? 200000 : 0; // Nếu là cabin VIP, cộng thêm 200K

                        // ✅ Lấy tổng số ghế trong cabin
                        Pattern pattern = Pattern.compile("\\d+");
                        Matcher matcher = pattern.matcher(cabinType);
                        int totalSeats = matcher.find() ? Integer.parseInt(matcher.group()) : 1; // Tránh lỗi `NoMatchFoundException`

                        // ✅ Công thức tính giá vé
                        price = distance * 550 + seatPrice * (200 - totalSeats) / 100 + vip;

                        // ✅ Cập nhật giá vé trong bảng `Seats`
                        String query2 = "UPDATE Seats SET price = ? WHERE cbid = ? AND seatNo = ?";

                        try (PreparedStatement ps2 = conn.prepareStatement(query2)) {
                            ps2.setInt(1, price);
                            ps2.setString(2, cabinId);
                            ps2.setInt(3, seatNo);

                            int affectedRows = ps2.executeUpdate();
                            if (affectedRows == 0) {
                                return -1; // Không cập nhật được ghế
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
        }
        return price; // Nếu không cập nhật được bất kỳ ghế nào
    }

    public int createTicket(Tickets ticket) {
        String query = "INSERT INTO Tickets (from_station, to_station, from_date, to_date, ttype, trid,sid,rid,cbid) "
                + "VALUES (?, ?, ?, ?, ?)";
        Timestamp timestamp1 = Timestamp.valueOf(ticket.getFrom_time());
        Timestamp timestamp2 = Timestamp.valueOf(ticket.getTo_time());
        try {
            PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, ticket.getFrom_station());
            ps.setString(2, ticket.getTo_station());
            ps.setTimestamp(3, timestamp1);
            ps.setTimestamp(4, timestamp2);
            ps.setInt(5, ticket.getTtype());
            ps.setString(6, ticket.getTrid());
            ps.setInt(7, ticket.getSid());
            ps.setInt(8, ticket.getRid());
            ps.setString(9, ticket.getCbid());

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error creating ticket: " + e.getMessage());
        }
        return -1;
    }

    public boolean createOrder(Order_Details order) {
        String query = "INSERT INTO Order_Details (tid,cid,status,total_price,payment_type,payment_date) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, order.getTid());
            ps.setInt(2, order.getCid());
            ps.setInt(3, order.getStatus());
            ps.setDouble(4, order.getTotal_price());
            ps.setInt(5, order.getPayment_type());
            ps.setTimestamp(6, new Timestamp(order.getPayment_date().getTime()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating order: " + e.getMessage());
        }
        return false;
    }

//    public boolean checkSeatAvailability(int trainId, String cabinId, int seatNumber) {
//        String query = "SELECT COUNT(*) FROM Tickets WHERE train_id = ? AND cabin_id = ? AND seat_number = ?";
//        try {
//            PreparedStatement ps = conn.prepareStatement(query);
//            ps.setInt(1, trainId);
//            ps.setString(2, cabinId);
//            ps.setInt(3, seatNumber);
//            
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return rs.getInt(1) == 0; // Return true if seat is available (count = 0)
//            }
//        } catch (SQLException e) {
//            System.out.println("Error checking seat availability: " + e.getMessage());
//        }
//        return false;
//    }
    public static void main(String[] args) throws ParseException, Exception {
        DAO dao = new DAO();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println(dao.searchSchedules("Sài Gòn", "Hà Nội", sdf.parse("2025-03-12")));
        System.out.println(dao.get1SeatWithCabinIdNSeatN0("SE1/1", 1).toString());
//        System.out.println(dao.updateSeatsPrice("Hà Nội", "Sài Gòn", 1, "A56LV", "SE1/1", 1));
//         System.out.println(dao.get1SeatWithCabinIdNSeatN0("SE1/1", 1).toString());
//        List<Schedule> listS = dao.searchSchedules("Hà Nội", "Sài Gòn", sdf.parse("2025-03-09"));
//        for (Schedule schedules : listS) {
//            List<Cabins> cabins = dao.searchCabinsWithTrainID(schedules.getTrid());
//            System.out.println(dao.searchCabinsWithTrainID(schedules.getTrid()));
//            System.out.println("lm");
//        }
//        System.out.println(dao.searchRoute("Hà Nội", "Sài Gòn"));
//        System.out.println(dao.searchAvailSeatsOfTrainWithScheduleID(64));
//System.out.println(dao.searchSchedules("Hà Nội", "Sài Gòn", sdf.parse("2025-03-06")));
//dao.searchCabinsWithTrainID("SE1");
//        System.out.println(dao.searchCabinsWithTrainID("SE1").toString());
        //  System.out.println(dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), sdf.parse("2025-03-03")));
//        System.out.println(dao.searchTrainIDWithRid(1));
//        System.out.println(dao.searchCabinsWithTrainID("SE1").get(0).toString());
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = "2025-02-22";
//        Date parsedDate = sdf.parse(dateString);
//        List<Schedules> list = dao.searchSchedules(dao.searchRoute("Hà Nội", "Sài Gòn"), parsedDate);
//        for (Schedules s : list) {
//            System.out.println(s);
//        }
//        System.out.println(dao.login("My", "123456"));
//        System.out.println(list);
//List<Accounts> listA = dao.getAllAccounts();
//        for (Routes o : list) {
//            System.out.println(o);
//        }
    }

    public int getTotalAccounts() {
        try {
            String sql = "SELECT COUNT(*) FROM Accounts";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("getTotalAccounts: " + e);
        }
        return 0;
    }

    public List<Accounts> getAccountsByPage(int page, int rowsPerPage) {
        List<Accounts> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Accounts ORDER BY uID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, (page - 1) * rowsPerPage);
            st.setInt(2, rowsPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(
                    rs.getInt("uID"),
                    rs.getString("uname"),
                    rs.getString("umail"),
                    rs.getString("pass"),
                    rs.getString("uphone"),
                    rs.getInt("isStaff"),
                    rs.getInt("isAdmin"),
                    rs.getString("cccd"),
                    rs.getString("avatar"),
                    rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println("getAccountsByPage: " + e);
        }
        return list;
    }
}
