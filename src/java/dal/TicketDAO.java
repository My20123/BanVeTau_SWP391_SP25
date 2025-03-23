package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Tickets;

/**
 *
 * @author
 */
public class TicketDAO {

    private Connection conn;

    public TicketDAO() {
        try {
            conn = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Tickets> getTicketsByRange(int page, int ticketsPerPage) {
        List<Tickets> tickets = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE id BETWEEN ? AND ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * ticketsPerPage);
            ps.setInt(2, ticketsPerPage);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tickets ticket = new Tickets();
                ticket.setId(rs.getInt("id"));
                ticket.setFrom_station(rs.getString("from_station"));
                ticket.setTo_station(rs.getString("to_station"));

                Timestamp fromTimeStamp = rs.getTimestamp("from_date");
                Timestamp toTimeStamp = rs.getTimestamp("to_date");

                ticket.setFrom_time(fromTimeStamp != null ? fromTimeStamp.toLocalDateTime() : null);
                ticket.setTo_time(toTimeStamp != null ? toTimeStamp.toLocalDateTime() : null);

                ticket.setTtype(rs.getInt("ttype"));
                ticket.setTrid(rs.getString("trid"));
                ticket.setSid(rs.getInt("sid"));
                ticket.setRid(rs.getInt("rid"));
                ticket.setCbid(rs.getString("cbid"));

                tickets.add(ticket);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public int getTotalTickets() {
        int total = 0;
        String query = "SELECT COUNT(*) FROM tickets";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Tickets> searchTicketById(int ticketId) {
        List<Tickets> tickets = new ArrayList<>();
        String sql = "SELECT * FROM tickets WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tickets ticket = new Tickets();
                ticket.setId(rs.getInt("id"));
                ticket.setFrom_station(rs.getString("from_station"));
                ticket.setTo_station(rs.getString("to_station"));

                // Chuyển đổi Timestamp sang LocalDateTime
                Timestamp fromTimeStamp = rs.getTimestamp("from_date");
                Timestamp toTimeStamp = rs.getTimestamp("to_date");

                ticket.setFrom_time(fromTimeStamp != null ? fromTimeStamp.toLocalDateTime() : null);
                ticket.setTo_time(toTimeStamp != null ? toTimeStamp.toLocalDateTime() : null);

                ticket.setTtype(rs.getInt("ttype"));
                ticket.setTrid(rs.getString("trid"));
                ticket.setSid(rs.getInt("sid"));
                ticket.setRid(rs.getInt("rid"));
                ticket.setCbid(rs.getString("cbid"));

                tickets.add(ticket);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public Tickets getTicketDetail(int ticketId) {
        Tickets ticket = null;
        String sql = "SELECT * FROM order_details d JOIN tickets t ON d.tid = t.id WHERE t.id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ticket = new Tickets();
                ticket.setId(rs.getInt("id"));
                ticket.setFrom_station(rs.getString("from_station"));
                ticket.setTo_station(rs.getString("to_station"));

                Timestamp fromTimeStamp = rs.getTimestamp("from_date");
                Timestamp toTimeStamp = rs.getTimestamp("to_date");

                ticket.setFrom_time(fromTimeStamp != null ? fromTimeStamp.toLocalDateTime() : null);
                ticket.setTo_time(toTimeStamp != null ? toTimeStamp.toLocalDateTime() : null);

                ticket.setTtype(rs.getInt("ttype"));
                ticket.setTrid(rs.getString("trid"));
                ticket.setSid(rs.getInt("sid"));
                ticket.setRid(rs.getInt("rid"));
                ticket.setCbid(rs.getString("cbid"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ticket;
    }

    public void updateTicketStatus(int ticketId) {
        String sql = "UPDATE tickets SET ttype = CASE WHEN ttype = 1 THEN 2 ELSE 1 END WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        TicketDAO dao = new TicketDAO();
        int startId = 0;
        int endId = 5;
        List<Tickets> ticketList = dao.getTicketsByRange(startId, endId);
        for (Tickets t : ticketList) {
            System.out.println(t);
        }

    }
}
