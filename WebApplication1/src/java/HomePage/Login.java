/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.AccountDBContext;
import DAO.Class_SessionDBContext;
import DAO.SchoolYearDBContext;
import DAO.SessionDBContext;
import DAO.StudentDBContext;
import Entity.Account;
import Entity.SchoolYear;
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
import java.text.SimpleDateFormat;
import java.util.Date;
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
        SchoolYearDBContext school = new SchoolYearDBContext();
        Date date = new Date();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        SchoolYear sch = school.getSchoolYearByDateNow(dateF.format(date));
        Class_SessionDBContext classSession = new Class_SessionDBContext();
        Account acc = db.getByUsernamePassword(user_raw, pass_raw);

        HttpSession session = request.getSession();
        if (acc != null) {
           if (acc.getRole() == 1) {
                List<Student> list = stu.getStudentByPid(acc.getPid());
                session.setAttribute("role", acc.getRole());
                session.setAttribute("pid", acc.getPid()); 
                
                response.sendRedirect("timetable?stuid=" + list.get(0).getStuid());
            } else if (acc.getRole() == 2) {

            } else if (acc.getRole() == 3) {
                response.sendRedirect("schedules?yid=" + sch.getYid() +"&csid=" + classSession.getClassSessionByYid(sch.getYid()).get(0).getCsid());
            }          
        } else {
            request.setAttribute("err", "username or password invalid!!! Please try again.");
            request.getRequestDispatcher("FE_Parent/Login.jsp").forward(request, response);
        }
       
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
