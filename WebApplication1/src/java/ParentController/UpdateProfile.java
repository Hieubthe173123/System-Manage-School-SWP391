/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package ParentController;

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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateProfile", urlPatterns = {"/update-profile"})
public class UpdateProfile extends HttpServlet {

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
         HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc != null) {
            // Retrieve parameters from the request
            int pid = acc.getPid();
            String pname = request.getParameter("pname");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String dob = request.getParameter("dob");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String IDcard = request.getParameter("IDcard");
            String nickname = request.getParameter("nickname");

            // Create a new Parent object and set its properties
            Parent parent = new Parent();
            parent.setPid(pid);
            parent.setPname(pname);
            parent.setGender(gender);
            parent.setDob(dob);
            parent.setAddress(address);
            parent.setPhoneNumber(phoneNumber);
            parent.setEmail(email);
            parent.setIDcard(IDcard);
            parent.setNickname(nickname);

            // Update the parent information in the database
            ParentDBContext parentDB = new ParentDBContext();
            parentDB.updateParent(parent);

            // Redirect to the parent profile page after update
           request.getRequestDispatcher("UpdateProfileParent.jsp").forward(request, response);
        } else {
            // Redirect to the login page if the user is not authenticated
            response.sendRedirect("login");
        }
    }

    @Override
    public String getServletInfo() {
        return "UpdateProfile Servlet";
    }
}
