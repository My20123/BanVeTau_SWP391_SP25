 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Tickets;

/**
 *
 * @author Acer
 */
@WebServlet("/ticketController") 
public class TicketController extends HttpServlet {

    private DAO DAO;

    @Override
    public void init() throws ServletException {
        DAO = new DAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TicketController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TicketController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                listTickets(request, response);
                break;
            case "search":
                searchTicket(request, response);
                break;
            case "viewDetail":
                viewTicketDetail(request, response);
                break;
            case "updateStatus":
                updateTicketStatus(request, response);
                break;
            default:
                listTickets(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void listTickets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String indexString = request.getParameter("index");
        if (indexString == null) {
            indexString = "1";
        }
        int index = Integer.parseInt(indexString);
        int ticketsPerPage = 5;
        int totalTickets = DAO.getTotalTickets();
        int endPage = totalTickets / ticketsPerPage;
        if (totalTickets % ticketsPerPage != 0) {
            endPage++;
        }
        List<Tickets> list = DAO.getTicketsByRange(index, ticketsPerPage);
        request.setAttribute("listT", list);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentPage", index);
        request.getRequestDispatcher("TicketHome.jsp").forward(request, response);
    }

    private void searchTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");

        if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
            int ticketId = Integer.parseInt(ticketIdStr);
            List<Tickets> tickets = DAO.searchTicketById(ticketId);
            request.setAttribute("listT", tickets);
        } else {
            request.setAttribute("error", "Vui lòng nhập ID vé hợp lệ!");
        }

        request.getRequestDispatcher("TicketHome.jsp").forward(request, response);
    }

    private void viewTicketDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");

        if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
            int ticketId = Integer.parseInt(ticketIdStr);
            Tickets ticket = DAO.getTicketDetail(ticketId);
            request.setAttribute("ticketDetail", ticket);
        } else {
            request.setAttribute("error", "Vui lòng chọn vé hợp lệ!");
        }

        request.getRequestDispatcher("TicketDetail.jsp").forward(request, response);
    }

    private void updateTicketStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");

        if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
            int ticketId = Integer.parseInt(ticketIdStr);
            DAO.updateTicketStatus(ticketId);
        }

        response.sendRedirect("ticketController");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
