/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Schedule;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditScheduleServlet", urlPatterns = {"/editschedule"})
public class EditScheduleServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            DAO dao = new DAO();
            
            // Get schedule details
            Schedule schedule = dao.getScheduleById(id);
            if (schedule == null) {
                response.sendRedirect("manageschedule?error=Schedule not found");
                return;
            }
            
            // Get lists for form dropdowns
            request.setAttribute("stations", dao.getAllStations());
            request.setAttribute("routes", dao.getAllRoutes());
            request.setAttribute("trains", dao.getAllTrains());
            request.setAttribute("schedule", schedule);
            
            request.getRequestDispatcher("EditSchedule.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in EditScheduleServlet doGet: " + e.getMessage());
            response.sendRedirect("manageschedule?error=Invalid input");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from the form
            int id = Integer.parseInt(request.getParameter("id"));
            String fromStation = request.getParameter("fromStation");
            String toStation = request.getParameter("toStation");
            String trid = request.getParameter("trid");
            String fromTimeStr = request.getParameter("fromTime");
            String toTimeStr = request.getParameter("toTime");
            
            // Get route ID based on from and to stations
            DAO dao = new DAO();
            int rid = dao.getRouteId(fromStation, toStation);
            
            // Convert string dates to Timestamp
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp fromTime = new Timestamp(dateFormat.parse(fromTimeStr).getTime());
            Timestamp toTime = new Timestamp(dateFormat.parse(toTimeStr).getTime());
            
            // Create Schedule object
            Schedule schedule = new Schedule();
            schedule.setId(id);
            schedule.setRid(rid);
            schedule.setTrid(trid);
            schedule.setTrainType(request.getParameter("trainType"));
            schedule.setFromStation(fromStation);
            schedule.setToStation(toStation);
            schedule.setFromTime(fromTime);
            schedule.setToTime(toTime);
            
            // Update in database
            boolean success = dao.updateSchedule(schedule);
            
            if (success) {
                response.sendRedirect("manageschedule?message=Update successful");
            } else {
                response.sendRedirect("editschedule?id=" + id + "&error=Update failed");
            }
            
        } catch (Exception e) {
            System.out.println("Error in EditScheduleServlet doPost: " + e.getMessage());
            response.sendRedirect("manageschedule?error=Invalid input");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for editing train schedules";
    }
}
