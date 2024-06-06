/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAO.ClassDBContext;
import DAO.LecturerClassSession;
import Entity.Class;
import Entity.Lecturers_Class_Session;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name="UpdateLecturerInClass", urlPatterns={"/update-lecturer-class"})
public class UpdateLecturerInClass extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LecturerClassSession lcs = new LecturerClassSession();
        String lid = request.getParameter("lid");
        List<Lecturers_Class_Session> list = lcs.getLecturerByid(lid);
        
        
        ClassDBContext cl = new ClassDBContext();
        List<Class> list1 = cl.getAllLecturersContain();
        request.setAttribute("listB", list1);
        request.setAttribute("listA",list);
        request.getRequestDispatcher("FE_Admin/UpdateLecturerInClass.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
        int lid_raw = 0;
        int classID_raw =0;
       String lid = request.getParameter("lid");
       String classID = request.getParameter("classID");
       try{
           lid_raw = Integer.parseInt(lid);
           classID_raw = Integer.parseInt(classID);
       }catch(Exception e){
           
       }
       
       Lecturers_Class_Session lcs = new Lecturers_Class_Session();
       lcs.setLclassID(classID_raw);
       LecturerClassSession lcs1 = new LecturerClassSession();
       lcs1.updateLecturerinClass(classID_raw, lid_raw);
       response.sendRedirect("lecturers");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
