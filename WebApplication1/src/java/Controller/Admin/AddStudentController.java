/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;


import DAO.ClassDBContext;

import DAO.StudentClassSessionDBContext;
import java.io.IOException;
import Entity.Class;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet(name="AddStudentController", urlPatterns={"/add-student"})
public class AddStudentController extends HttpServlet {
   
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ClassDBContext cl = new ClassDBContext();
         List<Class> list = cl.getAllClass();
        request.setAttribute("listA", list);
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
        String stuName = request.getParameter("sName");
        String stuDob = request.getParameter("sDob");
        String stuGender = request.getParameter("sGender");
        String stuAddress = request.getParameter("sAddress");
        String classId = request.getParameter("classId");

        String pname = request.getParameter("pname");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String phoneNumber = request.getParameter("phoneNumber");
        String IDcard = request.getParameter("IDcard");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");

        StudentClassSessionDBContext sdc = new StudentClassSessionDBContext();

        int studentCount = sdc.countStudentInClass(classId);
        if (studentCount >= 30) {
            request.setAttribute("mess", "Class is full. Please choose another class!");
        } else {
            sdc.addParent(pname, gender, dob, phoneNumber, IDcard, address, email, nickname, stuName, stuDob, stuGender, stuAddress, classId);
            request.setAttribute("mess", "Add new student successfully!");
        }
       
        response.sendRedirect("student");
    }

    
    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
