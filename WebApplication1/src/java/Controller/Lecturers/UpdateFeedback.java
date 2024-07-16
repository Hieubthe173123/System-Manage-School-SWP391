/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Lecturers;

import DAO.FeedbackDBContext;
import DAO.LecturersDBContext;
import Entity.Lecturers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hidung
 */
@WebServlet(name = "UpdateFeedback", urlPatterns = {"/update-feedback"})
public class UpdateFeedback extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve parameters and handle possible null values
            String fidStr = request.getParameter("fid");
            String stuid = request.getParameter("stuid");
            String feedbackTitle = request.getParameter("ftitle");
            String feedbackContent = request.getParameter("fcontent");
            String feedbackDate = request.getParameter("dateFeedback");
            String lecturerId = request.getParameter("lid");

        
            // Parse feedback ID to integer
            int feedbackId = Integer.parseInt(fidStr);
            int stu = Integer.parseInt(stuid);           
            // Update feedback in the database (Assume FeedbackDBContext handles this)
            FeedbackDBContext feedbackDB = new FeedbackDBContext();
            boolean isUpdated = feedbackDB.updateFeedback(feedbackId, stu, feedbackTitle, feedbackContent, feedbackDate);

            if (isUpdated) {
                // Redirect back to the feedback list page on success
                response.sendRedirect(request.getContextPath() + "/list-feedback?lecturerId=" + lecturerId + "&dateFeedback=" + feedbackDate);
            } else {
                // Handle the case where update fails
                request.setAttribute("errorMessage", "Failed to update feedback.");
                request.getRequestDispatcher("/error-page.jsp").forward(request, response);
            }
        } catch (NumberFormatException ex) {
            // Handle the case where fidStr cannot be parsed as an integer
            request.setAttribute("errorMessage", "Feedback ID must be a valid number.");
            request.getRequestDispatcher("/error-page.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateFeedback.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
