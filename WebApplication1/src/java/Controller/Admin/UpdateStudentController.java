/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.StudentDBContext;
import Entity.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name = "UpdateStudentController", urlPatterns = {"/update-student"})
public class UpdateStudentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/CRUD_Student.jsp").forward(request, response);
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
        String sname = request.getParameter("sname");
        String dob = request.getParameter("dob");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String address = request.getParameter("address");

        int studentId = 0;
        try {
            studentId = Integer.parseInt(stuid);
        } catch (NumberFormatException e) {

        }

        Student updatedStudent = new Student();
        updatedStudent.setStuid(studentId);
        updatedStudent.setSname(sname);
        updatedStudent.setDob(dob);
        updatedStudent.setGender(gender);
        updatedStudent.setAddress(address);

        StudentDBContext studentDB = new StudentDBContext();
        studentDB.updateStudent(updatedStudent);

        response.sendRedirect("student");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
