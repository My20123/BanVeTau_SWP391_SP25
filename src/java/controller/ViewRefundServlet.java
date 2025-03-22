/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tra my
 */
@WebServlet(name = "ViewRefundServlet", urlPatterns = { "/viewRefund" })
public class ViewRefundServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<Refund> refundRequests = new ArrayList<>();

        try {
            DAO dao = new DAO();

            // Lấy danh sách yêu cầu hoàn tiền
            refundRequests = dao.getALlRefund();

            if (refundRequests == null) {
                Logger.getLogger(ViewRefundServlet.class.getName()).log(
                        Level.WARNING, "Không có dữ liệu hoàn tiền được trả về");
                refundRequests = new ArrayList<>(); // Khởi tạo list rỗng nếu null
            }

            // Set attribute cho request
            request.setAttribute("refundRequests", refundRequests);

            // Forward đến trang RefundRequest.jsp
            request.getRequestDispatcher("RefundRequest.jsp").forward(request, response);

        } catch (Exception e) {
            Logger.getLogger(ViewRefundServlet.class.getName()).log(
                    Level.SEVERE, "Lỗi không xác định khi xử lý yêu cầu hoàn tiền", e);
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            // Forward đến trang lỗi hoặc trang RefundRequest.jsp với thông báo lỗi
            request.getRequestDispatcher("RefundRequest.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
