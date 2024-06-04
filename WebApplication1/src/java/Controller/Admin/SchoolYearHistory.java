/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.SchoolYearDBContext;
import DAO.StudentDBContext;
import Entity.Student;
import Entity.StudentClassSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
@WebServlet(name = "SchoolYearHistory", urlPatterns = {"/historyschoolyear"})
public class SchoolYearHistory extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        SchoolYearDBContext db = new SchoolYearDBContext();
        StudentDBContext studb = new StudentDBContext();
        ArrayList<Student> students = studb.getAllStudent();
        
        //Lấy tham số selectedStudent từ request
        String selectedStuid = request.getParameter("selectedStudent");
        try {
            //nếu có stuid sẽ hiện ra lịch sử của học sinh đó
            if (selectedStuid != null && !selectedStuid.isEmpty()) {
                ArrayList<StudentClassSession> history = db.getHistorySchoolYearbyStuid(selectedStuid);
                session.setAttribute("selectedStuid", selectedStuid);
                session.setAttribute("history", history);
            }
        } catch (Exception e) {
            //Xử Lý ngoại lệ
            e.printStackTrace();
            response.sendRedirect("Error/404.jsp");
            return;
        }

        session.setAttribute("students", students);
        request.getRequestDispatcher("FE_Admin/SchoolYearHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
