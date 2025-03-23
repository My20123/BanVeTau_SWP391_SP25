/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import dal.OrderDetailDAO;
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
public class ChangeRefundStatusServlet extends HttpServlet {

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
        DAO dao = new DAO();
        OrderDetailDAO orderDao= new OrderDetailDAO();

        try {
            String action = request.getParameter("action");
            String refundIdStr = request.getParameter("refundId");

            // Kiểm tra dữ liệu đầu vào
            if (action == null || action.isEmpty() || refundIdStr == null || refundIdStr.isEmpty()) {
                throw new IllegalArgumentException("Thiếu thông tin cần thiết");
            }

            int refundId = Integer.parseInt(refundIdStr);

            // Xử lý action
            if (action.equals("approve")) {
                dao.updateRefundStatus("APPROVED", refundId);                
                orderDao.updateOrderStatus(dao.searchOrderIDByRefundID(refundId), 3);
            } else if (action.equals("reject")) {
                dao.updateRefundStatus("REJECTED", refundId);
                orderDao.updateOrderStatus(dao.searchOrderIDByRefundID(refundId), 0);
            } else {
                throw new IllegalArgumentException("Action không hợp lệ");
            }

            // Chuyển hướng sau khi xử lý thành công
            response.sendRedirect("viewRefund");

        } catch (NumberFormatException e) {
            // Xử lý lỗi khi chuyển đổi refundId
            request.setAttribute("error", "ID hoàn tiền không hợp lệ");
            request.getRequestDispatcher("RefundRequest.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý các lỗi khác
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("RefundRequest.jsp").forward(request, response);
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
