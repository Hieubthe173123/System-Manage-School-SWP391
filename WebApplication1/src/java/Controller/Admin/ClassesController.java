/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.SchoolYearDBContext;
import Entity.ClassSession;
import Entity.Lecturers_Class_Session;
import Entity.SchoolYear;
import Entity.StudentClassSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ClassesController", urlPatterns = {"/classController"})
public class ClassesController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SchoolYearDBContext yearDB = new SchoolYearDBContext();
        ArrayList<SchoolYear> listYear = yearDB.getAllSchoolYear();

        String yid = request.getParameter("yid");
        String csid = request.getParameter("csid");
        try {
            if (yid != null && !yid.isEmpty()) {

                ArrayList<SchoolYear> selectedYear = yearDB.getSchoolYearById(yid);
                request.setAttribute("selectedYear", selectedYear);

                ArrayList<ClassSession> listClassSession = yearDB.getClassSessionByYid(yid);
                request.setAttribute("listClassSession", listClassSession);

            }

            if (csid != null && !csid.isEmpty()) {

                ArrayList<Lecturers_Class_Session> lecClassSessionbyCsid2 = yearDB.getLecturersByCsid(Integer.parseInt(csid));
                request.setAttribute("lecClassSessionbyCsid2", lecClassSessionbyCsid2);

                Lecturers_Class_Session lecClassSessionbyCsid = yearDB.getLecturerByCsid(Integer.parseInt(csid));
                request.setAttribute("lecClassSessionbyCsid", lecClassSessionbyCsid);

                ArrayList<StudentClassSession> studentClassSessionbyCsid = yearDB.getStudentClassSessionbyCsid(Integer.parseInt(csid));
                request.setAttribute("studentClassSessionbyCsid", studentClassSessionbyCsid);

            }
        } catch (Exception e) {
            System.out.println(e);
            response.sendRedirect("Error/404.jsp");
            return;
        }

        request.setAttribute("yid", yid);
        request.setAttribute("listYear", listYear);
        request.getRequestDispatcher("FE_Admin/Classes_function.jsp").forward(request, response);
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
