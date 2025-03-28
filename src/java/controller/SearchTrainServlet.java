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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tra my
 */
@WebServlet(name = "SearchTrainServlet", urlPatterns = { "/searchtrain" })
public class SearchTrainServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchTrainServlet.class.getName());

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Get DAO instance
            DAO dao = new DAO();

            // Get list of all stations for the form
            List<String> listS = dao.getAllStations();
            request.setAttribute("dao", dao);
            request.setAttribute("listS", listS);

            // Get form parameters from Home.jsp
            String tripType = request.getParameter("options");
            String fromStation = request.getParameter("from_station");
            String toStation = request.getParameter("to_station");
            String fromDate = request.getParameter("input_from");
            String returnDate = request.getParameter("input_to");

            // Nếu là khứ hồi, lấy giá trị từ form khứ hồi
            if ("roundTrip".equals(tripType)) {
                fromStation = request.getParameter("from_station_round");
                toStation = request.getParameter("to_station_round");
                fromDate = request.getParameter("input_from_round");
            }

            // Set form values as attributes to maintain them after search
            request.setAttribute("trip_type", tripType);
            request.setAttribute("depart", fromStation);
            request.setAttribute("desti", toStation);
            request.setAttribute("from_date", fromDate);
            request.setAttribute("return_date", returnDate);

            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date departDate = sdf.parse(fromDate);
            Date returnDateObj = null;
            if ("roundTrip".equals(tripType) && returnDate != null && !returnDate.trim().isEmpty()) {
                returnDateObj = sdf.parse(returnDate);
            }

            // Search for departure routes and schedules
            List<Schedule> departSchedules = dao.searchSchedules(fromStation, toStation, departDate);
            if (departSchedules == null || departSchedules.isEmpty()) {
                request.setAttribute("errorMessage", "Không tìm thấy chuyến tàu nào cho tuyến đường này.");
                request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                return;
            }

            // Set departure schedules attribute
            request.setAttribute("departSchedules", departSchedules);

            // If round trip, search for return routes and schedules
            if ("roundTrip".equals(tripType) && returnDateObj != null) {
                List<Schedule> returnSchedules = dao.searchSchedules(toStation, fromStation, returnDateObj);
                if (returnSchedules == null || returnSchedules.isEmpty()) {
                    request.setAttribute("errorMessage", "Không tìm thấy chuyến tàu nào cho tuyến đường về.");
                    request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                    return;
                }
                // Set return schedules attribute
                request.setAttribute("return_schedules", returnSchedules);
            }

            // Forward to search result page
            request.setAttribute("resetSeats", true);
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);

        } catch (ParseException e) {
            LOGGER.log(Level.SEVERE, "Error parsing date", e);
            request.setAttribute("error", "Định dạng ngày không hợp lệ");
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing search request", e);
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu tìm kiếm");
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Search Train Servlet - Handles train search functionality";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Get DAO instance
            DAO dao = new DAO();

            // Get list of all stations for the form
            List<String> listS = dao.getAllStations();
            request.setAttribute("dao", dao);
            request.setAttribute("listS", listS);

            // Get form parameters from SearchResult.jsp
            String tripType = request.getParameter("trip_type");
            String fromStation = request.getParameter("depart");
            String toStation = request.getParameter("desti");
            String fromDate = request.getParameter("from_date");
            String returnDate = request.getParameter("return_date");
          if(returnDate.isEmpty()) tripType="oneWay";
          else tripType="roundTrip";
            // Set form values as attributes to maintain them after search
            request.setAttribute("trip_type", tripType);
            request.setAttribute("depart", fromStation);
            request.setAttribute("desti", toStation);
            request.setAttribute("from_date", fromDate);
            request.setAttribute("return_date", returnDate);

            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date departDate = sdf.parse(fromDate);
            Date returnDateObj = null;
            if ("roundTrip".equals(tripType) && returnDate != null && !returnDate.trim().isEmpty()) {
                returnDateObj = sdf.parse(returnDate);
            }

            // Search for departure routes and schedules
            List<Schedule> departSchedules = dao.searchSchedules(fromStation, toStation, departDate);
            if (departSchedules == null || departSchedules.isEmpty()) {
                request.setAttribute("errorMessage", "Không tìm thấy chuyến tàu nào cho tuyến đường này.");
                request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                return;
            }

            // Set departure schedules attribute
            request.setAttribute("departSchedules", departSchedules);

            // If round trip, search for return routes and schedules
            if ("roundTrip".equals(tripType) && returnDateObj != null) {
                List<Schedule> returnSchedules = dao.searchSchedules(toStation, fromStation, returnDateObj);
                if (returnSchedules == null || returnSchedules.isEmpty()) {
                    request.setAttribute("errorMessage", "Không tìm thấy chuyến tàu nào cho tuyến đường về.");
                    request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
                    return;
                }
                // Set return schedules attribute
                request.setAttribute("return_schedules", returnSchedules);
            }

            // Forward to search result page
            request.setAttribute("resetSeats", true);
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);

        } catch (ParseException e) {
            LOGGER.log(Level.SEVERE, "Error parsing date", e);
            request.setAttribute("error", "Định dạng ngày không hợp lệ");
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing search request", e);
            request.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu tìm kiếm");
            request.getRequestDispatcher("SearchResult.jsp").forward(request, response);
        }
    }
}
