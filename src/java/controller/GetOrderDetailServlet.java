package controller;

import dal.OrderDetailDAO;
import java.io.IOException;
import java.io.PrintWriter;
import model.Order_Details;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GetOrderDetailServlet", urlPatterns = { "/get-order-detail" })
public class GetOrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy orderId từ request
            int orderId = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin đơn hàng từ DAO
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            Order_Details order = orderDetailDAO.getOrderById(orderId);

            if (order != null) {
                // Chuyển đổi đối tượng Order thành JSON
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(order);

                // Gửi response
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
            } else {
                // Trả về lỗi nếu không tìm thấy đơn hàng
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                PrintWriter out = response.getWriter();
                out.print("{\"error\": \"Không tìm thấy đơn hàng\"}");
            }
        } catch (Exception e) {
            // Xử lý lỗi
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