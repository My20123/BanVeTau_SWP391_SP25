package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Schedule;
import model.Cabins;
import model.Accounts;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment"})
public class PaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        
        if (action == null) {
            // Display payment page
            showPaymentPage(request, response);
        } else if (action.equals("process")) {
            // Process payment
            processPayment(request, response);
        }
    }

    private void showPaymentPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Accounts user = (Accounts) session.getAttribute("acc");
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get booking information from request/session
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String fromDate = request.getParameter("from_date");
            String totalAmount = request.getParameter("totalAmount");
            String scheduleId = request.getParameter("scheduleId");
            String cabinId = request.getParameter("cabinId");
            String seatNumber = request.getParameter("seatNumber");
            
            // Generate unique booking ID
            String bookingId = generateBookingId(user.getId());
            
            // Create payment info for QR code
            String paymentInfo = createPaymentInfo(bookingId, totalAmount);
            
            // Set attributes for the payment page
            request.setAttribute("from_station", fromStation);
            request.setAttribute("to_station", toStation);
            request.setAttribute("from_date", fromDate);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("paymentInfo", URLEncoder.encode(paymentInfo, StandardCharsets.UTF_8.toString()));
            
            // Forward to payment page
            request.getRequestDispatcher("Payment.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String generateBookingId(int userId) {
        // Generate a unique booking ID based on timestamp and user ID
        return "VT" + userId + System.currentTimeMillis();
    }

    private String createPaymentInfo(String bookingId, String amount) {
        // Create a formatted string for QR code
        // Format: BankID|AccNumber|Amount|Content
        return String.format("970436|1234567890|%s|VEDT%s", amount, bookingId);
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Accounts user = (Accounts) session.getAttribute("acc");
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Get payment details
            String scheduleId = request.getParameter("scheduleId");
            String cabinId = request.getParameter("cabinId");
            String paymentMethod = request.getParameter("paymentMethod");
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            
            // Get contact information
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            
            // Process payment based on payment method
            boolean paymentSuccess = processPaymentTransaction(paymentMethod, totalAmount);
            
            if (paymentSuccess) {
                // Create booking record
                DAO dao = new DAO();
                boolean bookingSuccess = dao.createBooking(user.getId(), scheduleId, cabinId, 
                                                         totalAmount, paymentMethod, name, email, phone);
                
                if (bookingSuccess) {
                    // Redirect to success page
                    response.sendRedirect("booking-success.jsp");
                } else {
                    // Handle booking failure
                    request.setAttribute("error", "Không thể tạo đơn đặt vé");
                    showPaymentPage(request, response);
                }
            } else {
                // Handle payment failure
                request.setAttribute("error", "Thanh toán thất bại");
                showPaymentPage(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    private boolean processPaymentTransaction(String paymentMethod, double amount) {
        // Add actual payment processing logic based on the payment method
        // This is a placeholder that always returns true
        return true;
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
}
