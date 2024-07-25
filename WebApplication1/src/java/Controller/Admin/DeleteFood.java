/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.FoodDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author hidung
 */
@WebServlet(name = "DeleteFood", urlPatterns = {"/admin/delete-food"})
public class DeleteFood extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int foodId = Integer.parseInt(request.getParameter("foodid"));
        FoodDBContext fooddb = new FoodDBContext();
        try {
            boolean isDeleted = fooddb.deleteFood(foodId);
            if (isDeleted) {
                response.sendRedirect(request.getContextPath() + "/admin/food");
            } 
        } catch (SQLException e) {
            response.sendRedirect("error.jsp"); // Redirect to an error page
            request.getRequestDispatcher("/food").forward(request, response);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
