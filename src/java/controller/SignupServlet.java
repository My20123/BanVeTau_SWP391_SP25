package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
@WebServlet(name="SignupServlet", urlPatterns={"/signup"})
public class SignupServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String user = request.getParameter("user");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pass = request.getParameter("pass");
        String re_pass = request.getParameter("repass");
        if (!pass.equals(re_pass)) {
            request.setAttribute("mess", "Password is not the same! Try again");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        } else if (!isValidEmail(email)) {
            request.setAttribute("mess", "Invalid email! Try again");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        } else if (!isValidPhone(phone)) {
            request.setAttribute("mess", "Invalid phone number ! Try again");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        } else {
            DAO dao = new DAO();
            Accounts a = dao.checkAccountExist(user);
            if (a == null) {
                //signup
                dao.singup(user, email, pass, phone);
                request.getRequestDispatcher("home").forward(request, response);
            } else   {
                request.setAttribute("mess", "Tài khoản đã tồn tại, vui lòng thử tài khoản khác.");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            }
        }
    }

    private boolean isValidEmail(String email) {
        return email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$");
    }

    private boolean isValidPhone(String phone) {
        return phone.matches("^(\\+?[0-9]{8,15})$");
    }

}