/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Authentication;

import Controller.Admin.*;
import DAO.AccountDBContext;
import Entity.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
@WebServlet(name = "AccountList", urlPatterns = {"/account-list"})
public class AccountList extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDBContext db = new AccountDBContext();

        String role = request.getParameter("role");
        String searchName = request.getParameter("searchName");

        ArrayList<Account> accountList;
        if (role != null && !role.isEmpty()) {
            accountList = db.getAllAccountByRole(role);
        } else {
            accountList = db.getAllAccount();
        }

        if (searchName != null && !searchName.isEmpty()) {
            // Lọc tài khoản theo tên người dùng, PID và LID
            String searchNameLower = searchName.toLowerCase();
            accountList.removeIf(account ->
                    !account.getUsername().toLowerCase().contains(searchNameLower)
                    && (account.getPid() == null || !account.getPid().getPname().toLowerCase().contains(searchNameLower))
                    && (account.getLid() == null || !account.getLid().getLname().toLowerCase().contains(searchNameLower))
            );
        }

        session.setAttribute("accountList", accountList);
        request.getRequestDispatcher("FE_Admin/AccountList.jsp").forward(request, response);
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
