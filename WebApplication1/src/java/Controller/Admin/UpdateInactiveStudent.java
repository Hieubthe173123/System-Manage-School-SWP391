/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAO.StudentDBContext;
import Entity.Student;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name="UpdateInactiveStudent", urlPatterns={"/update-inactive-student"})
public class UpdateInactiveStudent extends HttpServlet {
   
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         request.getRequestDispatcher("/FE_Admin/Inactive_Student.jsp").forward(request, response);
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String stuid = request.getParameter("stuid");
         boolean status = Boolean.parseBoolean(request.getParameter("status"));
         
         try {
        int Stuid = Integer.parseInt(stuid);
        
        Student stu = new Student();
        stu.setStuid(Stuid);
        stu.setStatus(status);

        StudentDBContext stuDB = new StudentDBContext();
        stuDB.updateStudentStatus(Stuid, status);
        
        response.sendRedirect("inactive-student");
    } catch (NumberFormatException e) {
    }
}
         
    

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
