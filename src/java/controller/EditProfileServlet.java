package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/editprofile"})
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("id");
        try {
            int id = Integer.parseInt(id_raw);
            DAO d = new DAO();
            Accounts u = d.GetUserById(id);
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String uname = request.getParameter("uname");
        String uphone = request.getParameter("uphone");
        String umail = request.getParameter("umail");
        String role = request.getParameter("role");

        DAO d = new DAO();
        d.updateUser(id, uname, uphone, umail, role);

        response.sendRedirect("User.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}