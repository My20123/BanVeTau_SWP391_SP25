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
            request.setAttribute("users", u);
            request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int uId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("uname");
        String phone = request.getParameter("uphone");
        String email = request.getParameter("umail");
        String cccd = request.getParameter("cccd");
        String avatar = request.getParameter("avatar");
        int role = Integer.parseInt(request.getParameter("role"));
        int isAdmin = (role == 1) ? 1 : 0;
        int isStaff = (role == 2) ? 1 : 0;
        DAO d = new DAO();
        d.updateUser(uId, name, phone, email, cccd,avatar, isAdmin,isStaff);

        HttpSession session = request.getSession();
        Accounts updatedUser = d.GetUserById(uId);
        session.setAttribute("acc", updatedUser);

        response.sendRedirect("User.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}