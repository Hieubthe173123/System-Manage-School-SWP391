/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllor.Lecturers;

import DAO.LecturersDBContext;
import Entity.Account;
import Entity.Lecturers;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name="UpdateProfileLecturers", urlPatterns={"/update-lecturers"})
public class UpdateProfileLecturers extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            LecturersDBContext lecDB = new LecturersDBContext();
            Lecturers lecturers = lecDB.getLecturerByid(acc.getLid());
            request.setAttribute("lecturers", lecturers);
             request.getRequestDispatcher("FE_Lecturer/UpdateProfileLecturers.jsp").forward(request, response);
    } 



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String lid = request.getParameter("lid");
        String lname = request.getParameter("lname");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dob = request.getParameter("dob");
        String phoneNumber = request.getParameter("phoneNumber");
        String IDCard = request.getParameter("IDCard");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String nickName = request.getParameter("nickName");
        
         if (lname == null || lname.trim().isEmpty()) {
            request.setAttribute("Error", "Please enter your name.");
            processRequest(request, response);
            return;
        }

        if (dob == null || dob.trim().isEmpty()) {
            request.setAttribute("Error", "Please enter your dob.");
             processRequest(request, response);
            return;
        }

        LocalDate dobDate = null;
        try {
            dobDate = LocalDate.parse(dob);
        } catch (DateTimeParseException e) {
            request.setAttribute("Error", "Invalid date format for Date of Birth. Please use yyyy-MM-dd format.");
            processRequest(request, response);
            return;
        }

        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("addressError", "Please enter your address.");
            processRequest(request, response);
            return;
        }
        if (!phoneNumber.matches("\\d{10}")) {
            request.setAttribute("Error", "Phone number must be 10 digits.");
            processRequest(request, response);
            return;
        }
         
         if (!IDCard.matches("\\d{12}")) {
            request.setAttribute("Error", "ID Card must be 12 digits.");
             processRequest(request, response);
            return;
        } 
         LecturersDBContext lec = new LecturersDBContext();
         if(lec.isIDCardLecExists(IDCard)){
              request.setAttribute("Error", "ID Card already exists.");
               processRequest(request, response);
            return;
         }
          // Update lecturer information
        int lecId = 0;
        try {
            lecId = Integer.parseInt(lid);
        } catch (NumberFormatException e) {
            request.setAttribute("Error", "Invalid Lecturers ID.");
            processRequest(request, response);
            return;
        }

        // Update lecturer information
        Lecturers updatedLec = new Lecturers();
        updatedLec.setLid(Integer.parseInt(lid));
        updatedLec.setLname(lname);
        updatedLec.setGender(gender);
        updatedLec.setDob(dob);
        updatedLec.setPhoneNumber(phoneNumber);
        updatedLec.setIDcard(IDCard);
        updatedLec.setAddress(address);
        updatedLec.setEmail(email);
        updatedLec.setNickname(nickName);

        // Update lecturer in database
        LecturersDBContext lecturersDB = new LecturersDBContext();
        lecturersDB.updateLecturer(updatedLec);

        
        response.sendRedirect("lecturers-profile"); 
        
        
        
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
   