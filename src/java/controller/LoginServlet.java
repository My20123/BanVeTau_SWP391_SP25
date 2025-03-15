package controller;

import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import model.Accounts;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        DAO dao = new DAO();
        Accounts a = dao.login(username, password);
        if (a == null) {
            request.setAttribute("mess", "Wrong username or password! Try again");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", a);
            session.setMaxInactiveInterval(1920);// 30p tự động xóa sesion
            
            // Kiểm tra nếu là tài khoản staff thì chuyển đến trang staffhome
            if (a.getIsStaff() == 1) {
                response.sendRedirect("StaffHome.jsp");
            } else {
                response.sendRedirect("home");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        DAO dao = new DAO();
        Accounts a = dao.login(username, password);
        if (a == null) {
            request.setAttribute("mess", "Wrong username or password! Try again");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", a);
            session.setMaxInactiveInterval(1920);// 30p tự động xóa sesion
            
            // Kiểm tra nếu là tài khoản staff thì chuyển đến trang staffhome
            if (a.getIsStaff() == 1) {
                response.sendRedirect("StaffHome.jsp");
            } else {
                response.sendRedirect("home");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
