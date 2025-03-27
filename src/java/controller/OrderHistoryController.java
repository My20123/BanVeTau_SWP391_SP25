package controller;

import dal.OrderDetailDAO;
import dal.DAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Accounts;
import model.Order_Details;

@WebServlet(name = "OrderHistoryController", urlPatterns = { "/order-history" })
public class OrderHistoryController extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Number of orders per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // if (session.getAttribute("account") == null) {
        // session.setAttribute("notificationErr", "Please login first!");
        // response.sendRedirect("login");
        // return;
        // }

        // Get logged-in user's id
        Accounts account = (Accounts) session.getAttribute("acc");
        int userId = account.getId();

        // Retrieve filter parameters
        String statusParam = request.getParameter("status");
        String keyword = request.getParameter("keyword");

        Integer status = null;
        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                status = Integer.valueOf(statusParam);
            } catch (NumberFormatException e) {
            }
        }

        // Get current page number from request parameter; default to 1
        int currentPage = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        OrderDetailDAO orderDAO = new OrderDetailDAO();
        DAO dao = new DAO();
        int totalRecords = orderDAO.countFilteredOrdersForUser(userId, status, keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        List<Order_Details> orderList = orderDAO.getFilteredOrdersForUser(userId, currentPage, PAGE_SIZE, status,
                keyword);
        List<String> listS = dao.getAllStations();
        request.setAttribute("listS", listS);
        request.setAttribute("orderList", orderList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("OrderHistory.jsp").forward(request, response);
    }
}
