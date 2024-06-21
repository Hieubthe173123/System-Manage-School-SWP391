/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllor.Lecturers;

import DAO.LecturersDBContext;
import Entity.Account;
import Entity.Lecturers;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name="LecturersProfile", urlPatterns={"/lecturers-profile"})
public class LecturersProfile extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          HttpSession session = request.getSession();
        String lid = request.getParameter("lid");
        Account acc = (Account) session.getAttribute("account");
        if(acc!=null) {
           LecturersDBContext lecDB = new LecturersDBContext();
           Lecturers lecturers = lecDB.getLecturerByid(acc.getLid());
           request.setAttribute("lecturers", lecturers);
            request.getRequestDispatcher("FE_Lecturer/LecturersProfile.jsp").forward(request, response);
        } else {
             response.sendRedirect("login");
        }
                   
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
