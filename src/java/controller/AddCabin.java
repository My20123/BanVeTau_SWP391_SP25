package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cabins;

/**
 *
 * @author lenovo
 */
@WebServlet(name="AddCabin", urlPatterns={"/addC"})
public class AddCabin extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCabin</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCabin at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("AddCabin.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("id");
        int number_seat = Integer.parseInt(request.getParameter("nseat"));
        int status = Integer.parseInt(request.getParameter("status"));
        int avail_seat = Integer.parseInt(request.getParameter("aseat"));
        String trid = request.getParameter("tid");
        String ctype = request.getParameter("ctype");
        int sid = Integer.parseInt(request.getParameter("sid"));

        DAO d = new DAO();
        if (d.GetCabinById(id) != null) {
            request.setAttribute("error", "Cabin ID already exists.");
            request.getRequestDispatcher("AddCabin.jsp").forward(request, response);
        } else {
            Cabins cabin = new Cabins(id, number_seat, status, avail_seat, trid, ctype, sid);
            try {
                d.addCabin(cabin);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("viewC");
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}