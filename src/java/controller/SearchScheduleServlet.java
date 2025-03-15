package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Accounts;
import model.Schedule;

/**
 * Servlet implementation class SearchScheduleServlet
 */

@WebServlet(name="SearchScheduleServlet", urlPatterns={"/searchschedule"})

public class SearchScheduleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String dateStr = request.getParameter("date");
            
            // Debug information
            System.out.println("Received search parameters:");
            System.out.println("fromStation: " + fromStation);
            System.out.println("toStation: " + toStation);
            System.out.println("date: " + dateStr);
            
            DAO dao = new DAO();
            List<Schedule> scheduleList = null;
            
            if(fromStation != null && toStation != null && dateStr != null 
               && !fromStation.isEmpty() && !toStation.isEmpty() && !dateStr.isEmpty()) {
                // Convert string date to Date object
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = sdf.parse(dateStr);
                
                // Search schedules based on criteria
                scheduleList = dao.searchSchedules(fromStation, toStation, date);
                
                // Set attributes for displaying search criteria
                request.setAttribute("from_station", fromStation);
                request.setAttribute("to_station", toStation);
                request.setAttribute("date", dateStr);
            }
            
            // Set scheduleList attribute (will be null if no search was performed)
            request.setAttribute("scheduleList", scheduleList);
            
            // Forward back to the search page
            request.getRequestDispatcher("ScheduleDetailSearch.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in SearchScheduleServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ScheduleDetailSearch.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
