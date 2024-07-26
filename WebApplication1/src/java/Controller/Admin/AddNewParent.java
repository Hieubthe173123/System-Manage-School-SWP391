/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.Class_SessionDBContext;
import DAO.ParentDBContext;
import DAO.StudentClassSessionDBContext;
import Entity.Account;
import Entity.ClassSession;
import Entity.Parent;
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
@WebServlet(name = "AddNewParent", urlPatterns = {"/admin/add-parent"})
public class AddNewParent extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Class_SessionDBContext cl = new Class_SessionDBContext();
        List<ClassSession> classIDs = cl.getAllClass();
        request.setAttribute("classIDs", classIDs);

        request.getRequestDispatcher("/FE_Admin/AddNewParent.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String pname = request.getParameter("pname");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dob = request.getParameter("dob");
        String phoneNumber = request.getParameter("phoneNumber");
        String IDcard = request.getParameter("IDcard");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");

        String sName = request.getParameter("sName");
        String sDob = request.getParameter("sDob");
        boolean sGender = Boolean.parseBoolean(request.getParameter("sGender"));
        String sAddress = request.getParameter("sAddress");
        int classId = Integer.parseInt(request.getParameter("classId"));

        ParentDBContext parentDB = new ParentDBContext();
        StudentClassSessionDBContext stuDB = new StudentClassSessionDBContext();

        // Validate Parent Info
        if (pname == null || !pname.matches("[\\p{L} ]+")) {
            request.setAttribute("Error", "Invalid name. Please enter again !");
            processRequest(request, response, account);
            return;
        }
        if (!phoneNumber.matches("^0\\d{9}$")) {
            request.setAttribute("ErrorPhone", "Phone number must be 10 digits.");
            processRequest(request, response, account);
            return;
        }
        if (parentDB.isPhoneNumberExists(phoneNumber)) {
            request.setAttribute("Error", "Phone number already exists.");
            processRequest(request, response, account);
            return;
        }

        if (!IDcard.matches("\\d{12}")) {
            request.setAttribute("ErrorIdCard", "ID Card must be 12 digits.");
            processRequest(request, response, account);
            return;
        }
        if (parentDB.isIDCardExists(IDcard)) {
            request.setAttribute("Error", "ID Card already exists.");
            processRequest(request, response, account);
            return;
        }


        // Validate Student Info
        if (sName == null || !sName.matches("[\\p{L} ]+")) {
            request.setAttribute("ErrorNameStu", "Invalid name. Please try again !");
            processRequest(request, response, account);
            return;
        }
        //Check if class is empty
        int maxStuInClass = 20;
        int totalStudentsInClass = stuDB.getTotalStudentsByClassId(String.valueOf(classId));
        if (totalStudentsInClass >= maxStuInClass) {
            request.setAttribute("ErrorClass", "The class is full. Please choose another class!");
            processRequest(request, response, account);
            return;
        }

        // Add Parent
        Parent parent = new Parent();
        parent.setPname(pname);
        parent.setGender(gender);
        parent.setDob(dob);
        parent.setPhoneNumber(phoneNumber);
        parent.setIDcard(IDcard);
        parent.setAddress(address);
        parent.setEmail(email);
        parent.setNickname(nickname);

        parentDB.addParent(parent);

        int newPid = parentDB.getMaxParentId();

        // Add Student
        boolean success = stuDB.addNewStudent(sName, dob, gender, address, newPid, classId);

        if (success) {
            response.sendRedirect("parent");
        } else {
            request.setAttribute("Error", "Failed to add student. Please try again.");
            processRequest(request, response, account);
        }
    }
}
