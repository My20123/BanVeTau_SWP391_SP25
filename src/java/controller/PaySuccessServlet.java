package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@WebServlet(name = "PaySuccessServlet", urlPatterns = { "/pay-success" })
public class PaySuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin từ session
            HttpSession session = request.getSession();
            Integer orderId = (Integer) session.getAttribute("orderId");
            String fromStation = (String) session.getAttribute("fromStation");
            String toStation = (String) session.getAttribute("toStation");
            List<Map<String, String>> selectedSeats = (List<Map<String, String>>) session.getAttribute("selectedSeats");
            Integer ttype = (Integer) session.getAttribute("ttype");
            Integer customerId = (Integer) session.getAttribute("customerId");

            if (orderId == null || fromStation == null || toStation == null ||
                    selectedSeats == null || ttype == null || customerId == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            // Lấy thông tin người đặt từ form
            String fullname = (String)session.getAttribute("fullname");
            String cccd = (String)session.getAttribute("cccd");
            String email = (String)session.getAttribute("email");
            String phone = (String)session.getAttribute("phone");

            DAO dao = new DAO();
            int distance=0;

            // Tạo thông tin người đặt
            boolean orderUserCreated = dao.createOrderUser(
                    orderId,
                    fullname,
                    cccd,
                    email,
                    phone);

            if (orderUserCreated) {
                // Tạo vé và thông tin hành khách
                List<Integer> ticketIds = new ArrayList<>();

                for (int i = 0; i < selectedSeats.size(); i++) {
                    Map<String, String> seat = selectedSeats.get(i);

                    // Chuyển đổi thời gian
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String fromTime = seat.get("fromTime").replace(".0", "");
                    String toTime = seat.get("toTime").replace(".0", "");

                    LocalDateTime fromDateTime = LocalDateTime.parse(fromTime, formatter);
                    LocalDateTime toDateTime = LocalDateTime.parse(toTime, formatter);

                    // Tạo vé mới
                    int ticketId = dao.createTicket(
                            fromDateTime,
                            toDateTime,
                            fromStation,
                            toStation,
                            ttype,
                            seat.get("selectedTrainId"),
                            Integer.parseInt(seat.get("seatNumber")),
                            dao.searchRoute(fromStation, toStation).getId(),
                            seat.get("selectedCabinId"));

                    if (ticketId > 0) {
                        ticketIds.add(ticketId);
                        // Tạo thông tin hành khách
                        String[] passengerNames = (String[])session.getAttribute("passengerNames");
                        String[] passengerCCCDs = (String[])session.getAttribute("passengerCCCDs");
                        dao.createTicketUser(ticketId, passengerNames[i], passengerCCCDs[i]);
                    }
                    
                // Tính distance
                    SimpleDateFormat format= new SimpleDateFormat("yyyy-MM-dd");
                 distance=dao.getDistance(fromStation, toStation, dao.searchScheduleWithTridNDate(seat.get("selectedTrainId"), format.parse(fromTime)).getId());
                

                dao.updateSeatStatus(dao.searchSeatId(Integer.parseInt(seat.get("seatNumber")), seat.get("selectedCabinId")), 2);
                }

                // Cập nhật Order_Tickets
                for (int ticketId : ticketIds) {
                    dao.createOrderTicket(orderId, ticketId);
                }

                // Cập nhật trạng thái đơn hàng thành 1 (đã thanh toán)
                dao.updateOrderStatus(orderId, 1);

                                // Set các thuộc tính cho request
                request.setAttribute("fromStation", fromStation);
                request.setAttribute("toStation", toStation);
                request.setAttribute("departureDate", session.getAttribute("fromDate"));
                request.setAttribute("departureTime", selectedSeats.get(0).get("fromTime"));
                request.setAttribute("arrivalTime", selectedSeats.get(0).get("toTime"));
                request.setAttribute("distance", distance); // Có thể tính toán khoảng cách thực tế
                request.setAttribute("selectedSeats", selectedSeats);

                // Xóa các thuộc tính trong session
                session.removeAttribute("orderId");
                session.removeAttribute("fromStation");
                session.removeAttribute("toStation");
                session.removeAttribute("fromDate");
                session.removeAttribute("selectedSeats");
                session.removeAttribute("ttype");
                session.removeAttribute("totalPrice");
                session.removeAttribute("customerId");

                // Forward đến trang payment-success.jsp
                request.getRequestDispatcher("payment-success.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}