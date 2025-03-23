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

@WebServlet(name = "AddFeedbackServlet", urlPatterns = {"/addfeedback"})
public class AddFeedbackServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Accounts acc = (Accounts) session.getAttribute("acc");
        
        if (acc == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String rateStr = request.getParameter("rate");
        String comment = request.getParameter("comment");
        
        if (rateStr != null && comment != null && !comment.trim().isEmpty()) {
            try {
                int rate = Integer.parseInt(rateStr);
                if (rate >= 1 && rate <= 5) {
                    DAO dao = new DAO();
                    dao.addFeedback(acc.getId(), rate, comment);
                    response.sendRedirect(request.getContextPath() + "/viewfeedback");
                    return;
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid rate value: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/Feedback.jsp?error=Giá trị xếp hạng không hợp lệ");
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/Feedback.jsp?error=Vui lòng cung cấp cả đánh giá và bình luận");
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