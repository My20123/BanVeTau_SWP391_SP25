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
import model.Trains;

/**
 *
 * @author lenovo
 */
@WebServlet(name="EditTrain", urlPatterns={"/editT"})
public class EditTrain extends HttpServlet {
   
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
            out.println("<title>Servlet EditTrain</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditTrain at " + request.getContextPath () + "</h1>");
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
        try{
            String id_train = request.getParameter("id");
            DAO d = new DAO();
            Trains t = d.GetTrainById(id_train);
            request.setAttribute("trains", t);
            request.getRequestDispatcher("EditTrain.jsp").forward(request, response);
        }catch(NumberFormatException e){
            System.out.println(e);
        }
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
        try {
            String tId = request.getParameter("id");
            String type = request.getParameter("type");
            int status = Integer.parseInt(request.getParameter("status"));
            int seat = Integer.parseInt(request.getParameter("seat"));
            int cabin = Integer.parseInt(request.getParameter("cabin"));
            int ava_seat = Integer.parseInt(request.getParameter("ava_seat"));
            
            // Validate the input
            if (seat < 1 || cabin < 1 || ava_seat < 0 || ava_seat > seat) {
                response.sendRedirect("viewT?error=invalid_input");
                return;
            }
            
            DAO d = new DAO();
            d.updateTrain(tId, type, status, seat, cabin, ava_seat);
            response.sendRedirect("viewT");
        } catch (Exception e) {
            System.out.println("Error updating train: " + e.getMessage());
            response.sendRedirect("viewT?error=update_failed");
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
