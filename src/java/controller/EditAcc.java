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
import model.Accounts;

/**
 *
 * @author lenovo
 */
@WebServlet(name = "editAcc", urlPatterns = {"/editAcc"})
public class EditAcc extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet editAcc</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet editAcc at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_user = request.getParameter("id");
        try {
            int id = Integer.parseInt(id_user);
            DAO d = new DAO();
            Accounts u = d.GetUserById(id);
            request.setAttribute("userss", u);
            request.getRequestDispatcher("editacc.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int Id = Integer.parseInt(request.getParameter("id"));
        String avatar = request.getParameter("avatar");
        String uname = request.getParameter("uname");
        String email = request.getParameter("umail");
        String phone = request.getParameter("uphone");
        String cccd = request.getParameter("cccd");
        int role = Integer.parseInt(request.getParameter("role"));

        int isAdmin = (role == 1) ? 1 : 0;
        int isStaff = (role == 2) ? 1 : 0;

        DAO d = new DAO();
        d.updateUser(Id, uname, phone, email, cccd, avatar,isAdmin, isStaff);
        response.sendRedirect("manageacc");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
