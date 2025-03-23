package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

@WebServlet(name = "UpdateFeedbackServlet", urlPatterns = {"/updatefeedback"})
public class UpdateFeedbackServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");
        
        if (acc == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String feedbackIdStr = request.getParameter("feedbackId");
        String rateStr = request.getParameter("rate");
        String comment = request.getParameter("comment");
        
        if (feedbackIdStr != null && rateStr != null && comment != null && !comment.trim().isEmpty()) {
            try {
                int feedbackId = Integer.parseInt(feedbackIdStr);
                int rate = Integer.parseInt(rateStr);
                if (rate >= 1 && rate <= 5) {
                    DAO dao = new DAO();
                    dao.updateFeedback(feedbackId, rate, comment);
                    response.sendRedirect(request.getContextPath() + "/viewfeedback");
                    return;
                } else {
                    response.sendRedirect(request.getContextPath() + "/Feedback.jsp?error=Đánh giá phải từ 1-5 sao");
                    return;
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid input values: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/Feedback.jsp?error=Dữ liệu không hợp lệ");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/Feedback.jsp?error=Vui lòng điền đầy đủ thông tin");
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