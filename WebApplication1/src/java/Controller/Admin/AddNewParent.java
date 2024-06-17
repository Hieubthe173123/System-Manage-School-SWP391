/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.ParentDBContext;
import Entity.Parent;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name = "AddNewParent", urlPatterns = {"/add-new-parent"})
public class AddNewParent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("FE_Admin/Parent_Management.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pname = request.getParameter("pname");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dob = request.getParameter("dob");
        String phoneNumber = request.getParameter("phoneNumber");
        String IDcard = request.getParameter("IDcard");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");

        // Kiểm tra tính hợp lệ của email và ngày tháng năm sinh
        if (!isValidEmail(email)) {
            request.setAttribute("emailError", "Invalid email format!");
            request.getRequestDispatcher("/WEB-INF/parentModal.jsp").forward(request, response);
            return;
        }

        if (!isValidDateOfBirth(dob)) {
            request.setAttribute("dobError", "Invalid date of birth format! Please use YYYY-MM-DD.");
            request.getRequestDispatcher("/WEB-INF/parentModal.jsp").forward(request, response);
            return;
        }

        Parent parent = new Parent();
        parent.setPname(pname);
        parent.setGender(gender);
        parent.setDob(dob);
        parent.setPhoneNumber(phoneNumber);
        parent.setIDcard(IDcard);
        parent.setAddress(address);
        parent.setEmail(email);
        parent.setNickname(nickname);

        ParentDBContext parentDB = new ParentDBContext();
        parentDB.addParent(parent);

        response.sendRedirect("parent");
    }

    // Hàm kiểm tra tính hợp lệ của email 
    private boolean isValidEmail(String email) {
        String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(regex);
    }

    private boolean isValidDateOfBirth(String dob) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        try {
            sdf.parse(dob);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
