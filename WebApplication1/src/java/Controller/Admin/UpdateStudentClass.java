/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.Class_SessionDBContext;
import DAO.StudentClassSessionDBContext;
import DAO.StudentDBContext;
import Entity.Account;
import Entity.ClassSession;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name="UpdateStudentClass", urlPatterns={"/admin/update-student-class"})
public class UpdateStudentClass extends  BaseRBACController {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
    Class_SessionDBContext cl = new Class_SessionDBContext();
          List<ClassSession> classIDs = cl.getAllClass2();
        request.setAttribute("classIDs", classIDs);
        request.getRequestDispatcher("/FE_Admin/UpdateStudentClass.jsp").forward(request, response);
  
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
        processRequest(request, response, account);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
        String className = request.getParameter("className");
        String stuid = request.getParameter("stuid");
        
         
         int newClassId = 0;
        try {
            newClassId = Integer.parseInt(className);
        } catch (NumberFormatException e) {
            request.setAttribute("classError", "Invalid Class ID.");
            processRequest(request, response, account);
            
            return;
        }
          int studentId = 0;
        try {
            studentId = Integer.parseInt(stuid);
        } catch (NumberFormatException e) {
            request.setAttribute("classError", "Invalid Student ID.");
            processRequest(request, response, account);
            return;
        }
         StudentClassSessionDBContext stuDB = new StudentClassSessionDBContext();
        int totalStudentsInNewClass = stuDB.getTotalStudentsByClassId(String.valueOf(newClassId));

        if (totalStudentsInNewClass >= 20) {
            request.setAttribute("Error", "The class is full. Please choose another class!");
            processRequest(request, response, account);
            
         } else {
            StudentDBContext studentDB = new StudentDBContext();
            studentDB.updateStudentClass(studentId, newClassId);
            response.sendRedirect("student");
        }
    }
    
//    private void forwardToUpdatePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String queryString = request.getQueryString();
//        String url = "/admin/update-student?" + queryString;
//        request.getRequestDispatcher(url).forward(request, response);
//    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}