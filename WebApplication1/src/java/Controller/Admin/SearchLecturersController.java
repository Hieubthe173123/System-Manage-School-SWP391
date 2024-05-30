/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import DAO.LecturerClassSession;
import Entity.Lecturers_Class_Session;
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
 * @author admin
 */
@WebServlet(name="SearchLecturersController", urlPatterns={"/search-lecturers"})
public class SearchLecturersController extends HttpServlet {
   
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
    
    // Lấy giá trị từ trường tìm kiếm
    String searchInput = request.getParameter("searchInput");
    
    // Gọi phương thức tìm kiếm theo id
    LecturerClassSession lcs = new LecturerClassSession();
    List<Lecturers_Class_Session> searchResultsById = lcs.getLecturerByid(searchInput);
    
    // Gọi phương thức tìm kiếm theo tên
    List<Lecturers_Class_Session> searchResultsByName = lcs.getLecturerByName(searchInput);
    
    // Kết hợp kết quả từ cả hai phương thức tìm kiếm
    List<Lecturers_Class_Session> combinedResults = new ArrayList<>();
    combinedResults.addAll(searchResultsById);
    combinedResults.addAll(searchResultsByName);
    
    // Chuyển kết quả đến trang JSP
    request.setAttribute("searchResults", combinedResults);
    request.getRequestDispatcher("FE_Admin/CRUD_Lecturers.jsp").forward(request, response);
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
        processRequest(request, response);
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
