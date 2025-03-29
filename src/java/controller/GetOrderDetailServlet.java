package controller;

import dal.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import model.Order_Details;
import model.Tickets;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet(name = "GetOrderDetailServlet", urlPatterns = { "/get-order-detail" })
public class GetOrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy orderId từ request
            int orderId = 24;
                    //Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin đơn hàng từ DAO
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            Order_Details order = orderDetailDAO.getOrderById(orderId);

            if (order != null) {
                // Tạo Map để chứa thông tin chi tiết
                Map<String, Object> orderDetail = new HashMap<>();

                // Thêm thông tin cơ bản của đơn hàng
                orderDetail.put("orderId", order.getId());
                orderDetail.put("totalPrice", order.getTotal_price());

                // Format ngày thanh toán
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                orderDetail.put("paymentDate", dateFormat.format(order.getPayment_date()));

                // Thêm trạng thái đơn hàng
                String statusText = "";
                switch (order.getStatus()) {
                    case 0:
                        statusText = "Bị từ chối";
                        break;
                    case 1:
                        statusText = "Hoàn thành";
                        break;
                    case 2:
                        statusText = "Chờ xử lý";
                        break;
                    case 3:
                        statusText = "Đã hoàn tiền";
                        break;
                    default:
                        statusText = "Không xác định";
                }
                orderDetail.put("status", statusText);

                // Tạo danh sách vé
                List<Map<String, Object>> ticketsList = new ArrayList<>();
                for (Tickets ticket : order.getTickets()) {
                    Map<String, Object> ticketInfo = new HashMap<>();

                    // Thêm thông tin vé
//                    ticketInfo.put("seatNumber", ticket.getSeat_number());
                    ticketInfo.put("cabinId", ticket.getCbid());
                    ticketInfo.put("departureDate", dateFormat.format(ticket.getFrom_time()));
//                    ticketInfo.put("ticketClass", ticket.getSeat_type());
                    ticketInfo.put("fromStation", ticket.getFrom_station());
                    ticketInfo.put("toStation", ticket.getTo_station());

                    // Format thời gian
                    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
                    ticketInfo.put("departureTime", timeFormat.format(ticket.getFrom_time()));
                    ticketInfo.put("arrivalTime", timeFormat.format(ticket.getTo_time()));

                    ticketsList.add(ticketInfo);
                }
                orderDetail.put("tickets", ticketsList);

                // Chuyển đổi Map thành JSON
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(orderDetail);

                // Gửi response
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
            } else {
                // Trả về lỗi nếu không tìm thấy đơn hàng
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                PrintWriter out = response.getWriter();
                out.print("{\"error\": \"Không tìm thấy đơn hàng\"}");
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi chuyển đổi orderId
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"ID đơn hàng không hợp lệ\"}");
        } catch (Exception e) {
            // Xử lý các lỗi khác
            e.printStackTrace(); // In stack trace để debug
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"error\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Servlet để lấy thông tin chi tiết đơn hàng";
    }
}