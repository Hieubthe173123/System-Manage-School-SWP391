/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAO.StudentClassSessionDBContext;
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
@WebServlet(name="InactiveStudentController", urlPatterns={"/inactive-student"})
public class InactiveStudentController extends HttpServlet {
   
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String indexPage = request.getParameter("index");
        
        StudentClassSessionDBContext stu = new StudentClassSessionDBContext();
        
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
         List<StudentClassSession> studentList = stu.getStudentInactiveClassSessionByLatestSchoolYearWithPaging(index);
         int count = stu.getTotalStudentInactiveByLatestSchoolYear();
          int endPage = count / 10;
            if (count % 10 != 0) {
                endPage++;
            }
            request.setAttribute("inactive", studentList);
            request.setAttribute("index", index);
            request.setAttribute("endPage", endPage);
            
           request.getRequestDispatcher("FE_Admin/Inactive_Student.jsp").forward(request, response);
       
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
