package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Order_Details;
import model.Tickets;

public class OrderDetailDAO extends DBContext {

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof java.util.Date) {
                ps.setTimestamp(i++, new Timestamp(((java.util.Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }
        }
    }

    public Tickets getTicketById(int ticketId) {
        String sql = "SELECT * FROM Tickets WHERE id = ?";
        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Tickets ticket = new Tickets();
                ticket.setFrom_station(rs.getString("from_station"));
                ticket.setTo_station(rs.getString("to_station"));
                // Set additional ticket fields if needed.
                return ticket;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order_Details> getFilteredOrdersForUser(int userId, int page, int pageSize, Integer status,
            String keyword) {
        List<Order_Details> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT * FROM Order_details WHERE cid = ?");
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (status != null) {
            sql.append(" AND status = ?");
            params.add(status);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND id IN (SELECT od.id FROM Order_details od JOIN Tickets t ON od.tid = t.id " +
                    "WHERE t.from_station LIKE ? OR t.to_station LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        sql.append(" ORDER BY payment_date DESC LIMIT ?, ?");
        int start = (page - 1) * pageSize;
        params.add(start);
        params.add(pageSize);

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            mapParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order_Details order = new Order_Details();
                order.setId(rs.getInt("id"));
                order.setTid(rs.getInt("tid"));
                order.setCid(rs.getInt("cid"));
                order.setStatus(rs.getInt("status"));
                order.setTotal_price(rs.getInt("total_price"));
                order.setPayment_date(rs.getDate("payment_date"));

                // Retrieve the Ticket using getTicketById instead of manual mapping.
                Tickets ticket = getTicketById(order.getTid());
                order.setTickets(ticket);

                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int countFilteredOrdersForUser(int userId, Integer status, String keyword) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Order_details od JOIN Tickets t ON od.tid = t.id WHERE od.cid = ?");
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (status != null) {
            sql.append(" AND od.status = ?");
            params.add(status);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (t.from_station LIKE ? OR t.to_station LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            mapParams(ps, params);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateOrderStatus(int orderId, int status) {
        String sql = "UPDATE Order_details SET status = ? WHERE id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Order_Details getOrderById(int orderId) {
        String sql = "SELECT * FROM Order_details WHERE id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order_Details order = new Order_Details();
                order.setId(rs.getInt("id"));
                order.setTid(rs.getInt("tid"));
                order.setCid(rs.getInt("cid"));
                order.setStatus(rs.getInt("status"));
                order.setTotal_price(rs.getInt("total_price"));
                order.setPayment_date(rs.getDate("payment_date"));

                // Retrieve the Ticket using getTicketById
                Tickets ticket = getTicketById(order.getTid());
                order.setTickets(ticket);

                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
