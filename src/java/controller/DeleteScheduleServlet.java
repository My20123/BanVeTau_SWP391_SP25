package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteScheduleServlet", urlPatterns = {"/deleteschedule"})
public class DeleteScheduleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            
            if (id == null || id.isEmpty()) {
                response.sendRedirect("manageschedule?error=Invalid schedule ID");
                return;
            }

            DAO dao = new DAO();
            boolean success = dao.deleteSchedule(Integer.parseInt(id));

            if (success) {
                response.sendRedirect("manageschedule");
            } else {
                response.sendRedirect("manageschedule?error=Không thể xóa lịch trình");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("Error in DeleteScheduleServlet: Invalid ID format");
            e.printStackTrace();
            response.sendRedirect("manageschedule?error=ID không hợp lệ");
        } catch (Exception e) {
            System.out.println("Error in DeleteScheduleServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("manageschedule?error=Có lỗi xảy ra khi xóa lịch trình");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 