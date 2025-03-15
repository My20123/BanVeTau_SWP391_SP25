/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import Config.VNPAYService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/pay")
public class PaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = "DH" + System.currentTimeMillis();
        long amount = 100000; // Ví dụ: 100,000 VNĐ

        String paymentUrl = VNPAYService.createPaymentUrl(amount, orderId);

        if (paymentUrl != null) {
            response.sendRedirect(paymentUrl);
        } else {
            response.getWriter().println("Lỗi khi tạo URL thanh toán.");
        }
    }
}

