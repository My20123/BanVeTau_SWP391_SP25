package controller;

import dal.DAO;
import model.Seats;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddSeat", urlPatterns = {"/addSeat"})
public class AddSeat extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cabinId = request.getParameter("cabinId");
        int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
        DAO dao = new DAO();

        try {
            int lastSeatNo = dao.getLastSeatNoByCabinId(cabinId); // Lấy số ghế cao nhất của Cabin
            for (int i = 1; i <= totalSeats; i++) {
                int seatNo = lastSeatNo + i;
                Seats seat = new Seats(0, seatNo, 0, 1158900, cabinId); // ID tự động, Status = Available
                dao.addSeat(seat);
            }
            response.sendRedirect("ManageSeat"); // Chuyển hướng về trang quản lý ghế
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding seats.");
            request.getRequestDispatcher("AddSeat.jsp").forward(request, response);
        }
    }
}
