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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.*;

@WebServlet(name = "BookingServlet", urlPatterns = { "/processOrder" })
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            DAO dao = new DAO();

            // Get session data
            HttpSession session = request.getSession();
            Accounts acc = (Accounts) session.getAttribute("acc");

            // Xóa thông tin cũ trong session
            session.removeAttribute("orderId");
            session.removeAttribute("fromStation");
            session.removeAttribute("toStation");
            session.removeAttribute("fromDate");
            session.removeAttribute("selectedSeats");
            session.removeAttribute("ttype");
            session.removeAttribute("totalPrice");
            session.removeAttribute("customerId");

            // Get values from request parameters
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

            // Chuyển đổi JSON thành List<Map>
            Gson gson = new Gson();
            Type listType = new TypeToken<List<Map<String, String>>>() {
            }.getType();
            List<Map<String, String>> selectedSeats = gson.fromJson(seats, listType);

            // Tính tổng giá vé
            int totalPrice = 0;
            for (Map<String, String> seat : selectedSeats) {
                totalPrice += Integer.parseInt(seat.get("price"));
            }

            // Tạo đơn hàng với status 4 (chờ thanh toán)
            Instant instant = Instant.now();
            Date date = Date.from(instant);
            int orderId = dao.createOrder(totalPrice, date, acc.getId());

            if (orderId > 0) {
                // Lưu thông tin mới vào session
                session.setAttribute("orderId", orderId);
                session.setAttribute("fromStation", fromStation);
                session.setAttribute("toStation", toStation);
                session.setAttribute("fromDate", fromDate);
                session.setAttribute("selectedSeats", selectedSeats);
                session.setAttribute("ttype", ttype);
                session.setAttribute("totalPrice", totalPrice);
                session.setAttribute("customerId", acc.getId());

                // Set các thuộc tính cho request
                request.setAttribute("selectedSeats", selectedSeats);
                request.setAttribute("account", acc);
                request.setAttribute("order", true);

                // Forward to order page
                request.getRequestDispatcher("Order.jsp").forward(request, response);
            } else {
                response.sendRedirect("SearchResult.jsp?error=create_order_failed");
            }
        } catch (Exception ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("SearchResult.jsp");
    }
}
