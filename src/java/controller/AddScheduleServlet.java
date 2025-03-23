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
import model.Trains;

@WebServlet(name = "AddScheduleServlet", urlPatterns = {"/addschedule"})
public class AddScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get list of stations and trains for the form
        DAO dao = new DAO();
        request.setAttribute("stations", dao.getAllStations());
        request.setAttribute("routes", dao.getAllRoutes());
        request.setAttribute("trains", dao.getAllTrains());

        request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DAO dao = new DAO();
            String fromStation = request.getParameter("fromStation");
            String toStation = request.getParameter("toStation");
            String trid = request.getParameter("trid");
            String trainType = request.getParameter("trainType");

            // Validate input
            if (fromStation == null || toStation == null || trid == null || trainType == null || 
                fromStation.trim().isEmpty() || toStation.trim().isEmpty() || 
                trid.trim().isEmpty() || trainType.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
                request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
                return;
            }

            // Validate stations are not the same
            if (fromStation.equals(toStation)) {
                request.setAttribute("error", "Ga đi và ga đến không được trùng nhau");
                request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
                return;
            }

            // Convert times
            String fromTimeStr = request.getParameter("fromTime");
            String toTimeStr = request.getParameter("toTime");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp fromTime = new Timestamp(dateFormat.parse(fromTimeStr).getTime());
            Timestamp toTime = new Timestamp(dateFormat.parse(toTimeStr).getTime());

            // Validate times
            if (fromTime.before(new Timestamp(System.currentTimeMillis()))) {
                request.setAttribute("error", "Thời gian đi không được trong quá khứ");
                request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
                return;
            }

            if (toTime.before(fromTime)) {
                request.setAttribute("error", "Thời gian đến phải sau thời gian đi");
                request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
                return;
            }

            // Create schedule object
            Schedule schedule = new Schedule();
            schedule.setFromStation(fromStation);
            schedule.setToStation(toStation);
            schedule.setTrid(trid);
            schedule.setTrainType(trainType);
            schedule.setFromTime(fromTime);
            schedule.setToTime(toTime);

            // Save to database
            boolean success = dao.addSchedule(schedule);

            if (success) {
                response.sendRedirect("manageschedule");
            } else {
                request.setAttribute("error", "Không thể thêm lịch trình. Vui lòng kiểm tra lại thông tin");
                request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("Error in AddScheduleServlet doPost: " + e.getMessage());
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("AddSchedule.jsp").forward(request, response);
        }
    }
}
