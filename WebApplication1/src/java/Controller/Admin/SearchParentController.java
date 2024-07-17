/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.ParentDBContext;
import Entity.Account;
import Entity.Parent;
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
@WebServlet(name="SearchParentController", urlPatterns={"/admin/search-parent"})
public class SearchParentController extends BaseRBACController {
   
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String searchInput = request.getParameter("searchInput");
        List<Parent> combinedResults = new ArrayList<>();
        ParentDBContext pdb = new ParentDBContext();
        
         if (searchInput != null && !searchInput.isEmpty()) {
            try {
                int id = Integer.parseInt(searchInput);
                Parent parentByID = pdb.getParentByid(id);
                if (parentByID != null) {
                    combinedResults.add(parentByID);
                }
            } catch (NumberFormatException e) {
                // Search by name
                List<Parent> parentByName = pdb.getParentByName(searchInput);
                combinedResults.addAll(parentByName);
            }
        }

        request.setAttribute("searchparent", combinedResults);
        request.getRequestDispatcher("/FE_Admin/Parent_Management.jsp").forward(request, response);
    }
    

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
        processRequest(request, response, account);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
    throws ServletException, IOException {
        processRequest(request, response, account);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
