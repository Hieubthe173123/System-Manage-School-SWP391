/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.ClassDBContext;
import DAO.Class_SessionDBContext;
import DAO.ParentDBContext;
import DAO.StudentClassSessionDBContext;
import Entity.Account;
import Entity.ClassSession;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "AddStudentController", urlPatterns = {"/admin/add-student"})
public class AddStudentController extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {

        //list class
//         ClassDBContext clDB = new ClassDBContext();
//        List<Entity.Class> clList = clDB.getAllClasses();
//        request.setAttribute("clasList", clList);
        Class_SessionDBContext cl = new Class_SessionDBContext();
        List<ClassSession> classIDs = cl.getAllClass2();
        request.setAttribute("classIDs", classIDs);
        request.getRequestDispatcher("/FE_Admin/AddNewStudent.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String sName = request.getParameter("sName");
        String sDob = request.getParameter("sDob");
        boolean sGender = Boolean.parseBoolean(request.getParameter("sGender"));
        String sAddress = request.getParameter("sAddress");
        String classIdStr = request.getParameter("classId");
        String parentIdStr = request.getParameter("parentId");

        if (classIdStr == null || classIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Class ID is required.");
            processRequest(request, response, account);
            return;
        }

        int classId;
        try {
            classId = Integer.parseInt(classIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Class ID.");
            processRequest(request, response, account);
            return;
        }

        if (parentIdStr == null || parentIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Parent ID is required.");
            processRequest(request, response, account);
            return;
        }

        int parentId;
        try {
            parentId = Integer.parseInt(parentIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Parent ID.");
            processRequest(request, response, account);
            return;
        }

        if (sName == null || !sName.matches("[\\p{L} ]+")) {
            request.setAttribute("error", "Invalid name. Please try again !");
            processRequest(request, response, account);
            return;
        }


        int maxStuInClass = 20;
        StudentClassSessionDBContext stuDB = new StudentClassSessionDBContext();
        int totalStudentsInClass = stuDB.getTotalStudentsByClassId(String.valueOf(classId));
        if (totalStudentsInClass >= maxStuInClass) {
            request.setAttribute("error", "The class is full. Please choose another class!");
            processRequest(request, response, account);
            return;
        }

        StudentClassSessionDBContext stu = new StudentClassSessionDBContext();
        boolean success = stu.addNewStudent(sName, sDob, sGender, sAddress, parentId, classId);
        response.sendRedirect("parent");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
