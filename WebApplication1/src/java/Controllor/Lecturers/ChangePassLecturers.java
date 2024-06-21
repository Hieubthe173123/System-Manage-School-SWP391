/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllor.Lecturers;

import DAO.AccountDBContext;
import Entity.Account;
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
@WebServlet(name="ChangePassLecturers", urlPatterns={"/changepass"})
public class ChangePassLecturers extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          request.getRequestDispatcher("/FE_Lecturer/ChangePassLecturers.jsp").forward(request, response);
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 


   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPass = request.getParameter("old-password");
        String newPass = request.getParameter("new-password");
        String confirmPass = request.getParameter("confirm-password");

        Account ac = (Account) request.getSession().getAttribute("account");

        if (oldPass == null || !oldPass.equals(ac.getPassword())) {
            request.setAttribute("mess", "Old password did not match!");

        } else if (!newPass.equals(confirmPass)) {
            request.setAttribute("mess", "New password and confirm password do not match!");

        } else if (!isPasswordStrong(newPass)) {
            request.setAttribute("mess", "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one special character!");

        } else {
            AccountDBContext acc = new AccountDBContext();
            request.setAttribute("mess", "Change password successfully!");
            ac.setPassword(newPass);
            acc.changePassLecurers(ac.getLid(), newPass);
            request.getSession().setAttribute("account", ac);
        }
        request.getRequestDispatcher("/FE_Lecturer/ChangePassLecturers.jsp").forward(request, response);
    }

    private boolean isPasswordStrong(String password) {
        return password.length() >= 8 &&
               password.matches(".*[A-Z].*") &&
               password.matches(".*[a-z].*") &&
               password.matches(".*[!@#$%^&*()-_=+\\|[{]};:'\",<.>/?].*");
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
