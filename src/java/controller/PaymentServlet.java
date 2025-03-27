/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Config.VNPAYService;
import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/pay")
public class PaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ session
        HttpSession session = request.getSession();

        // Kiểm tra thông tin trong session
        Integer orderId = (Integer) session.getAttribute("orderId");
        Integer totalPrice = (Integer) session.getAttribute("totalPrice");
        
String fullname = request.getParameter("name");
            String cccd = request.getParameter("cccd");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
             String[] passengerNames = request.getParameterValues("passengerName[]");
                        String[] passengerCCCDs = request.getParameterValues("passengerCCCD[]");
                        
                        session.setAttribute("fullname", fullname);
                        session.setAttribute("cccd", cccd);
                        session.setAttribute("email", email);
                        session.setAttribute("phone", phone);
                        session.setAttribute("passengerNames", passengerNames);
                        session.setAttribute("passengerCCCDs", passengerCCCDs);
        if (orderId == null || totalPrice == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Không tìm thấy thông tin đặt vé\"}");
            return;
        }

        // Tạo mã đơn hàng và URL thanh toán
        String orderID = "DH" + System.currentTimeMillis();
        String paymentUrl = VNPAYService.createPaymentUrl(totalPrice, orderID);

        if (paymentUrl != null) {
            response.sendRedirect(paymentUrl);
        } else {
            response.getWriter().println("Lỗi khi tạo URL thanh toán.");
        }
    }
}
