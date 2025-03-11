package controller;

import dal.DAO;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.*;


@WebServlet(name = "BookingServlet", urlPatterns = {"/processOrder"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
            // Get session data
            HttpSession session = request.getSession();
            
            // Get DAO instance
            DAO dao = new DAO();
            
            // Get values from request parameters first
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String fromDate = request.getParameter("from_date");
            String seats=request.getParameter("selectedSeats");           
            
            
            // Store these values back in session for persistence
            session.setAttribute("depart", fromStation);
            session.setAttribute("desti", toStation);
            session.setAttribute("from_date", fromDate);
            
            // Create test data for Order.jsp
            Instant instant=Instant.now();
            Date date=Date.from(instant);
            Order_Details order = new Order_Details(2, 2, 5, 1, 1037000, 1,date );
           
             Gson gson = new Gson();
        List<Object> selectedSeats = gson.fromJson(seats, new TypeToken<List<Object>>() {}.getType());

request.setAttribute("selectedSeats", selectedSeats);


            dao.createOrder(order);
            // Set the order object for JSP
            request.setAttribute("order", order);
            
            // Forward to order page
            request.getRequestDispatcher("Order.jsp").forward(request, response);
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        
        try {
            // Get order ID from request
            String orderId = request.getParameter("orderId");
            if (orderId != null) {
                // Create test order for display
                 Instant instant=Instant.now();
            Date date=Date.from(instant);
            Order_Details order = new Order_Details(2, 2, 5, 1, 1037000, 1,date );
           
            
                
                
                
                
                // Set order in request for Order.jsp
                request.setAttribute("order", order);
                request.getRequestDispatcher("Order.jsp").forward(request, response);
                return;
            }
            
            // If no order ID, redirect to search
            response.sendRedirect("SearchResult.jsp");
            
        } catch (Exception e) {
            System.out.println("Error in OrderServlet doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("SearchResult.jsp");
        }
    }
}
