package controller;

import dal.DAO;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.time.format.DateTimeFormatter;
import java.lang.reflect.Type;
import java.util.Map;
import model.*;

@WebServlet(name = "BookingServlet", urlPatterns = { "/processOrder" })
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Get session data
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");

        // Get DAO instance
        DAO dao = new DAO();

        // Get values from request parameters first
        String fromStation = request.getParameter("from_station");
        String toStation = request.getParameter("to_station");
        String fromDate = request.getParameter("from_date");
        String seats = request.getParameter("selectedSeats");
        String tripType = request.getParameter("trip_type");

        // Xử lý trip_type để set ttype
        int ttype = 1; // Mặc định là oneWay
        if ("roundTrip".equals(tripType)) {
            ttype = 2;
        }

        // Store these values back in session for persistence
        session.setAttribute("depart", fromStation);
        session.setAttribute("desti", toStation);
        session.setAttribute("from_date", fromDate);

        // Create test data for Order.jsp
        Instant instant = Instant.now();
        Date date = Date.from(instant);
        Order_Details order = new Order_Details(2, 2, 5, ttype, 1037000, 1, date);

        // Set account information in request
        request.setAttribute("account", acc);

        // Chuyển đổi JSON thành List<Map>
        Gson gson = new Gson();
        Type listType = new TypeToken<List<Map<String, String>>>() {
        }.getType();
        List<Map<String, String>> selectedSeats = gson.fromJson(seats, listType);

        // Tạo vé cho từng ghế
        for (Map<String, String> seat : selectedSeats) {
            // Lấy thông tin từ ghế
            String fromTime = seat.get("fromTime");
            String toTime = seat.get("toTime");
            String seatNumber = seat.get("seatNumber");
            String cabinId = seat.get("selectedCabinId");
            String trainId = seat.get("selectedTrainId");
            String price = seat.get("price");

            try {
                // Chuyển đổi thời gian từ String sang LocalDateTime
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");

                // Lấy ngày từ fromDate và kết hợp với thời gian
                String fromDateTimeStr = fromDate + " " + fromTime;
                String toDateTimeStr = fromDate + " " + toTime;

                LocalDateTime fromDateTime = LocalDateTime.parse(fromDateTimeStr, formatter);
                LocalDateTime toDateTime = LocalDateTime.parse(toDateTimeStr, formatter);

                // Tạo vé với thông tin của ghế
                dao.createTicket(fromDateTime, toDateTime, fromStation, toStation, ttype, price,
                        Integer.parseInt(seatNumber), dao.searchRoute(fromStation, toStation).getId(), cabinId);
            } catch (Exception e) {
                System.out.println("Lỗi khi xử lý thời gian: " + e.getMessage());
                e.printStackTrace();
                // Có thể thêm xử lý lỗi ở đây
            }
        }

        request.setAttribute("selectedSeats", selectedSeats);
//        dao.createOrder(order);
//        // Set the order object for JSP
//        request.setAttribute("order", order);

        // Forward to order page
        request.getRequestDispatcher("Order.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();

        try {
            // Get order ID from request
            String orderId = request.getParameter("orderId");
            if (orderId != null) {
                // Create test order for display
                Instant instant = Instant.now();
                Date date = Date.from(instant);
                Order_Details order = new Order_Details(2, 2, 5, 1, 1037000, 1, date);

                // Set order in request for Order.jsp
                request.setAttribute("order", order);
                request.getRequestDispatcher("Order.jsp").forward(request, response);
                return;
            }

            // If no order ID, redirect to search
            response.sendRedirect("SearchResult.jsp");

        } catch (Exception e) {
            System.out.println("Error in OrderServlet doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("SearchResult.jsp");
        }
    }
}
