/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.AccountDBContext;
import DAO.StudentDBContext;
import Entity.Account;
import Entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author DELL
 */
@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("FE_Parent/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String user_raw = request.getParameter("username");
        String pass_raw = request.getParameter("password");
        AccountDBContext db = new AccountDBContext();
        StudentDBContext stu = new StudentDBContext();

        Account acc = db.getByUsernamePassword(user_raw, pass_raw);

        // Inside your login servlet or controller
        HttpSession session = request.getSession();
        Account account = new Account();
// Assume account is populated with user data after login validation
        session.setAttribute("account", acc);
        if (acc != null) {
            if (acc.getRole() == 1) {
                List<Student> list = stu.getStudentByPid(acc.getPid());
                session.setAttribute("role", acc.getRole());
                request.setAttribute("pid", acc.getPid());
                request.setAttribute("list", list);
                request.getRequestDispatcher("FE_Parent/StudentOfParent.jsp").forward(request, response);
            } else if (acc.getRole() == 2) {

            } else if (acc.getRole() == 3){                                                            
                request.getRequestDispatcher("FE_Admin/Admin_Home.jsp").forward(request, response);
            }

            request.setAttribute("err", "Login Success");
        } else {
            request.setAttribute("err", "username or password invalid!!! Please try again.");

        }
        request.getRequestDispatcher("FE_Parent/Login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
