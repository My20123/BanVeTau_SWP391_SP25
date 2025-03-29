package dal;

import java.lang.System.Logger.Level;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
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
                // Chuyển đổi Timestamp sang LocalDateTime
                LocalDateTime fromTime = null;
                LocalDateTime toTime = null;

                Timestamp fromTimestamp = rs.getTimestamp("from_date");
                Timestamp toTimestamp = rs.getTimestamp("to_date");

                if (fromTimestamp != null) {
                    fromTime = fromTimestamp.toLocalDateTime();
                }
                if (toTimestamp != null) {
                    toTime = toTimestamp.toLocalDateTime();
                }

                // Tạo đối tượng Ticket
                return new Tickets(
                        rs.getInt("id"),
                        rs.getString("from_station"),
                        rs.getString("to_station"),
                        fromTime,
                        toTime,
                        rs.getInt("ttype"),
                        rs.getString("trid"),
                        rs.getInt("sid"),
                        rs.getInt("rid"),
                        rs.getString("cbid"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void setTicketsForOrder(Order_Details order) {
        String sql = "SELECT t.* FROM Tickets t " +
                "JOIN Order_Tickets ot ON t.id = ot.ticket_id " +
                "WHERE ot.order_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, order.getId());
            ResultSet rs = ps.executeQuery();

            List<Tickets> ticketsList = new ArrayList<>();

            while (rs.next()) {
                // Chuyển đổi Timestamp sang LocalDateTime
                LocalDateTime fromTime = null;
                LocalDateTime toTime = null;

                Timestamp fromTimestamp = rs.getTimestamp("from_date");
                Timestamp toTimestamp = rs.getTimestamp("to_date");

                if (fromTimestamp != null) {
                    fromTime = fromTimestamp.toLocalDateTime();
                }
                if (toTimestamp != null) {
                    toTime = toTimestamp.toLocalDateTime();
                }

                // Tạo đối tượng Ticket
                Tickets ticket = new Tickets(
                        rs.getInt("id"),
                        rs.getString("from_station"),
                        rs.getString("to_station"),
                        fromTime,
                        toTime,
                        rs.getInt("ttype"),
                        rs.getString("trid"),
                        rs.getInt("sid"),
                        rs.getInt("rid"),
                        rs.getString("cbid"));

                ticketsList.add(ticket);
            }

            order.setTickets(ticketsList);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Order_Details> getFilteredOrdersForUser(int userId, int page, int pageSize, Integer status,
            String keyword) {
        List<Order_Details> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT od.* FROM Order_details od " +
                        "WHERE od.cid = ?");

        if (status != null) {
            sql.append(" AND od.status = ?");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (t.from_station LIKE ? OR t.to_station LIKE ?)");
        }

        // Thêm phân trang
        sql.append(" ORDER BY od.payment_date DESC LIMIT ? OFFSET ?");

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, userId);

            if (status != null) {
                ps.setInt(paramIndex++, status);
            }

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchKeyword = "%" + keyword + "%";
                ps.setString(paramIndex++, searchKeyword);
                ps.setString(paramIndex++, searchKeyword);
            }

            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, (page - 1) * pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order_Details order = new Order_Details();
                order.setId(rs.getInt("id"));
                order.setCid(rs.getInt("cid"));
                order.setStatus(rs.getInt("status"));
                order.setTotal_price(rs.getInt("total_price"));
                order.setPayment_date(rs.getDate("payment_date"));

                // Set tickets cho order
                setTicketsForOrder(order);

                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int countFilteredOrdersForUser(int userId, Integer status, String keyword) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT od.id) FROM Order_details od " +
                        "JOIN Order_Tickets ot ON od.id = ot.order_id " +
                        "JOIN Tickets t ON ot.ticket_id = t.id " +
                        "WHERE od.cid = ?");
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

    public boolean updateOrderStatus(int orderId, int status) throws Exception {
        String sql = "UPDATE Order_details SET status = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, status);
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true;  // Cập nhật thành công
            } else {
                return false; // Không có dòng nào bị ảnh hưởng
            }

        } catch (SQLException e) {
            return false; // Xử lý lỗi
        }
    }

    public Order_Details getOrderById(int orderId) {
        String sql = "SELECT od.*, t.id AS ticket_id, t.from_station, t.to_station, t.from_date, t.to_date, " +
                "t.trid AS train_id, t.sid AS seat_id " +
                "FROM Order_details od " +
                "JOIN Order_Tickets ot ON od.id = ot.order_id " +
                "JOIN Tickets t ON ot.ticket_id = t.id " +
                "WHERE od.id = ?";

        try (Connection conn = getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            Order_Details order = null;
            List<Tickets> ticketsList = new ArrayList<>();

            while (rs.next()) {
                if (order == null) {
                    order = new Order_Details();
                    order.setId(rs.getInt("id"));
                    order.setCid(rs.getInt("cid"));
                    order.setStatus(rs.getInt("status"));
                    order.setTotal_price(rs.getInt("total_price"));
                    order.setPayment_date(rs.getDate("payment_date"));
                }

                // Tạo đối tượng Tickets và thêm vào danh sách
                Tickets ticket = new Tickets();
                ticket.setId(rs.getInt("ticket_id"));
                ticket.setFrom_station(rs.getString("from_station"));
                ticket.setTo_station(rs.getString("to_station"));

                // ✅ Sửa lỗi: Chuyển từ Timestamp sang LocalDateTime
                Timestamp fromTimestamp = rs.getTimestamp("from_date");
                Timestamp toTimestamp = rs.getTimestamp("to_date");

                if (fromTimestamp != null) {
                    ticket.setFrom_time(fromTimestamp.toLocalDateTime());
                }
                if (toTimestamp != null) {
                    ticket.setTo_time(toTimestamp.toLocalDateTime());
                }

                ticket.setTrid(rs.getString("train_id"));
                ticket.setSid(rs.getInt("seat_id"));

                ticketsList.add(ticket);
            }

            if (order != null) {
                order.setTickets(ticketsList);
            }

            return order;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void deleteOrdersWithStatus4() {
    String disableSafeMode = "SET SQL_SAFE_UPDATES = 0;";
    String deleteQuery = "DELETE FROM Order_details WHERE status = 4;";
    String enableSafeMode = "SET SQL_SAFE_UPDATES = 1;";

    try (Connection conn = getConnection();
         Statement stmt = conn.createStatement()) { 
        
        // Tắt chế độ SQL_SAFE_UPDATES
        stmt.executeUpdate(disableSafeMode);
        
        // Xóa dữ liệu có status = 4
        int rowsDeleted = stmt.executeUpdate(deleteQuery);
        System.out.println("Deleted " + rowsDeleted + " rows.");

        // Bật lại SQL_SAFE_UPDATES
        stmt.executeUpdate(enableSafeMode);
        
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    public static void main(String[] args)  {
        OrderDetailDAO orderdao= new OrderDetailDAO();
        try {
            System.out.println(orderdao.updateOrderStatus(19, 3));
        } catch (Exception ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }
}
