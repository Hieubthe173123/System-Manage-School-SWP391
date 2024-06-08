/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Authentication;

import DAO.AccountDBContext;
import Entity.Account;
import Entity.Lecturers;
import Entity.Parent;
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
@WebServlet(name = "AuthenticationAccount", urlPatterns = {"/authentication-account"})
public class AuthenticationAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

        AccountDBContext accdb = new AccountDBContext();

        //Lấy Danh Sách các tài khoản mới được tạo , phụ huynh và Giáo Viên
        ArrayList<Account> newAccountList = accdb.getOnlyNewAccount();
        ArrayList<Parent> availableParents = accdb.getPidNotExitsAccount();
        ArrayList<Lecturers> availableLecturers = accdb.getLidNotExitsAccount();

        //Lưu vào Session
        HttpSession session = request.getSession();
        session.setAttribute("newAccountList", newAccountList);
        session.setAttribute("availableParents", availableParents);
        session.setAttribute("availableLecturers", availableLecturers);

        request.getRequestDispatcher("FE_Admin/AuthenticationAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        ArrayList<Account> newAccountList = (ArrayList<Account>) session.getAttribute("newAccountList");
        String aid = request.getParameter("aid");
        AccountDBContext accdb = new AccountDBContext();
        
        if (aid != null && !aid.isEmpty()) {
            try {
                accdb.deleteAccount(aid);
                session.setAttribute("successMessage", "Account deleted successfully");
            } catch (Exception e) {
                System.out.println(e);
                session.setAttribute("errorMessage", "Failed to delete account");
            }
            response.sendRedirect("authentication-account");
            return;
        }

        try {
            
            for (int i = 0; i < newAccountList.size(); i++) {
                String roleStr = request.getParameter("role-" + i);
                String pid = request.getParameter("pid-" + i);
                String lid = request.getParameter("lid-" + i);

                int role;
                //Chuyển Role thành int
                //nếu role tồn tại thì sẽ conver => int
                if (roleStr != null && !roleStr.isEmpty()) {
                    role = Integer.parseInt(roleStr);
                    //Ngược lại set mặc định = 0
                } else {
                    role = 0;
                }
                Account acc = newAccountList.get(i);
                acc.setRole(role);

                //nếu role = 1 (Parent) => set Pid cho Account
                if (role == 1) {
                    Parent parent = new Parent();
                    parent.setPid(Integer.parseInt(pid));
                    acc.setPid(parent);
                    //có pid => lid null
                    acc.setLid(null);
                } else if (role == 2) {
                    //nếu role = 2 (Lecturers) => set Lid cho Account
                    Lecturers lecturer = new Lecturers();
                    lecturer.setLid(Integer.parseInt(lid));
                    acc.setPid(null);
                    //có lid => pid null
                    acc.setLid(lecturer);
                } else if (role == 3) {
                    //nếu role = 3 (Admin) => set Pid cho Account
                    acc.setPid(null);
                    acc.setLid(null);
                }

                //Update
                accdb.updateAuthenticationAccount3(acc);
            }

        } catch (Exception e) {
            System.out.println(e);
            response.sendRedirect("Error/404.jsp");
            return;
        }

        response.sendRedirect("account-list");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
