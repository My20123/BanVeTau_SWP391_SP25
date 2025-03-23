package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Trains;

@WebServlet(name = "AddTrain", urlPatterns = {"/addT"})
public class AddTrain extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        String type = request.getParameter("type");
        int status = Integer.parseInt(request.getParameter("status"));
        int seat = Integer.parseInt(request.getParameter("seat"));
        int cabin = Integer.parseInt(request.getParameter("cabin"));
        int ava_seat = Integer.parseInt(request.getParameter("ava_seat"));
        DAO dao = new DAO();

        if (dao.trainExists(id)) {
            request.setAttribute("errorMessage", "Train ID already exists.");
            request.getRequestDispatcher("AddTrain.jsp").forward(request, response);
        } else {
            dao.addTrain(new Trains(id, type, status, seat, cabin, ava_seat));
            response.sendRedirect("viewT");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}