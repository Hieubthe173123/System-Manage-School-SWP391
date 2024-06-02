/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAO.StudentClassSessionDBContext;
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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name="SearchStudentController", urlPatterns={"/search-student"})
public class SearchStudentController extends HttpServlet {
   

    //search by ID and by Name
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get the value of the searchInput parameter
        String searchInput = request.getParameter("searchInput");

        //call methods to search students by ID and name
        StudentClassSessionDBContext scs = new StudentClassSessionDBContext();
        List<StudentClassSession> searchResultsById = scs.getStudentClassSessionByID(searchInput);
        List<StudentClassSession> searchResultsByName = scs.getStudentClassSessionByName(searchInput);

        //a new list and add all the results from the two lists searchResultsById and searchResultsByName
        List<StudentClassSession> combinedResults = new ArrayList<>();
        combinedResults.addAll(searchResultsById);
        combinedResults.addAll(searchResultsByName);

        request.setAttribute("list", combinedResults);
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
