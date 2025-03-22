package controller;

import dal.DAO;
import dal.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Order_Details;
import model.Refund;
import java.sql.Date;
import model.Accounts;

@WebServlet(name = "CancelOrderServlet", urlPatterns = { "/cancel-order" })
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Accounts acc=(Accounts)request.getSession().getAttribute("acc");
            DAO dao = new DAO();
            // Lấy thông tin từ form
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            // Lấy thông tin order
            OrderDetailDAO orderDAO = new OrderDetailDAO();
            Order_Details order = orderDAO.getOrderById(orderId);

            if (order != null && order.getStatus() == 1) {
                // Cập nhật trạng thái order
                orderDAO.updateOrderStatus(orderId, 2); // 2 = Đã hủy
                
dao.updateRefundStatus("PENDING", orderId);
                // Tạo refund request mới
                java.util.Date currentDate = new java.util.Date();
                dao.createRefund(orderId, acc.getUname(), order.getTotal_price(), currentDate);

                response.sendRedirect("order-history");
            } else {
                response.sendRedirect("order-history?message=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}