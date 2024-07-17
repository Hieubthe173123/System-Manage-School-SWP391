/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Lecturers;

import Authentication.BaseRBACController;
import DAO.FeedbackDBContext;
import DAO.LecturersDBContext;
import Entity.Account;
import Entity.Lecturers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ListFeedback", urlPatterns = {"/lecturers/list-feedback"})
public class ListFeedback extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String lecturerIdStr = request.getParameter("lecturerId");
        String dateFeedback = request.getParameter("dateFeedback");

        LecturersDBContext lecDB = new LecturersDBContext();
        Lecturers lecturer = lecDB.getLecturerByid(Integer.parseInt(lecturerIdStr));

        request.setAttribute("lec", lecturer);
        //int lid = Integer.parseInt(lecturerIdStr);
        FeedbackDBContext fb = new FeedbackDBContext();
        List<Entity.Feedback> feedback = fb.getFeedbacksForLecturerAndDate(lecturerIdStr, dateFeedback);

        // Set feedback in request attribute and forward to JSP
        request.setAttribute("feedback", feedback);
        request.getRequestDispatcher("/FE_Lecturers/Feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
