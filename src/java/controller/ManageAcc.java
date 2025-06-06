package controller;

import dal.DAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;

@WebServlet(name = "ManageAcc", urlPatterns = {"/manageacc"})
public class ManageAcc extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageAcc</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageAcc at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    Accounts user = (Accounts) session.getAttribute("acc");

    if (user != null && user.getIsAdmin() == 1) {
        DAO d = new DAO();

        // Lấy tham số trang hiện tại
        String pageParam = request.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        int recordsPerPage = 8; // Số bản ghi trên mỗi trang

        // Lấy danh sách tài khoản theo trang
        List<Accounts> list = d.getAccountsByPage(page, recordsPerPage);
        int totalRecords = d.getTotalAccounts();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // Gửi dữ liệu đến JSP
        request.setAttribute("uAcc", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        RequestDispatcher dis = request.getRequestDispatcher("ManageAcc.jsp");
        dis.forward(request, response);
    } else {
        response.sendRedirect("404.html");
    }
}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("changeStatus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            DAO d = new DAO();
            d.updateStatus(id);
            response.getWriter().write("Success");
        } else {
            processRequest(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}