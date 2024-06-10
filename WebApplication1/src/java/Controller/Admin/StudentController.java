/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.SchoolYearDBContext;
import DAO.StudentClassSessionDBContext;
import DAO.StudentDBContext;
import Entity.SchoolYear;
import Entity.Student;
import Entity.StudentClassSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name = "StudentController", urlPatterns = {"/student"})
public class StudentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        StudentClassSessionDBContext stu = new StudentClassSessionDBContext();
        SchoolYearDBContext sy = new SchoolYearDBContext();
        StudentDBContext sdc = new StudentDBContext();
        

        String timeStart = request.getParameter("timeStart");
        String timeEnd = request.getParameter("timeEnd");
        String indexPage = request.getParameter("index");
        
        if (timeStart != null && timeEnd != null) {
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        int count = stu.getTotalStudentBySchoolYear(timeStart, timeEnd);
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        List<StudentClassSession> list = stu.getStudentClassSessionBySchoolYearWithPaging(timeStart, timeEnd, index);
        request.setAttribute("listC", list);
        request.setAttribute("index", index);
        request.setAttribute("endPage", endPage);
        
         } else {
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        int count = stu.getTotalStudent();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        List<Student> list1 = sdc.pagingStudent(index);
        request.setAttribute("listA", list1);
        request.setAttribute("index", index);
        request.setAttribute("endPage", endPage);
        }
        

        List<SchoolYear> list2 = sy.getAllSchoolYear();
        request.setAttribute("list2", list2);
        request.getRequestDispatcher("FE_Admin/CRUD_Student.jsp").forward(request, response);
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
