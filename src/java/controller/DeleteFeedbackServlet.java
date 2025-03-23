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

@WebServlet(name = "DeleteFeedbackServlet", urlPatterns = {"/deletefeedback"})
public class DeleteFeedbackServlet extends HttpServlet {
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
        
        if (feedbackIdStr != null) {
            try {
                int feedbackId = Integer.parseInt(feedbackIdStr);
                DAO dao = new DAO();
                dao.deleteFeedback(feedbackId);
                response.sendRedirect(request.getContextPath() + "/viewfeedback");
                return;
            } catch (NumberFormatException e) {
                System.out.println("Invalid feedback ID: " + e.getMessage());
            }
        }
        
        response.sendRedirect("Feedback.jsp");
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