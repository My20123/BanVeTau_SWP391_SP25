package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Schedule;

@WebServlet(name="ManageScheduleServlet", urlPatterns={"/manageschedule"})

public class ManageScheduleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            DAO dao = new DAO();
            
            // Xử lý phân trang
            int page = 1;
            int recordsPerPage = 5;
            
            String pageStr = request.getParameter("page");
            if(pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
            
            // Xử lý sắp xếp
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            
            List<Schedule> schedules = dao.getSchedulesByPage(page, recordsPerPage, null);
            int totalRecords = dao.getTotalSchedules();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            
            request.setAttribute("schedules", schedules);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            
            request.getRequestDispatcher("ManagementSchedules.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in ManageScheduleServlet: " + e.getMessage());
            e.printStackTrace();
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
        return "Servlet for managing train schedules";
    }
}
