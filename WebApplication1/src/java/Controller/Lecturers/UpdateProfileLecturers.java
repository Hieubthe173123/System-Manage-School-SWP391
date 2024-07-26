package Controller.Lecturers;

import Authentication.BaseRBACController;
import DAO.LecturerClassSession;
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

/**
 *
 * @author NGUYEN THI KHANH VI
 */
@WebServlet(name = "UpdateProfileLecturers", urlPatterns = {"/lecturers/update-lecturers"})
public class UpdateProfileLecturers extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");
        LecturersDBContext lecDB = new LecturersDBContext();
        Lecturers lecturers = lecDB.getLecturerByid(acc.getLid().getLid());
        request.setAttribute("lecturers", lecturers);
        request.getRequestDispatcher("/FE_Lecturers/UpdateProfileLecturers.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
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

        if (!checkValidInput(request, lname, phoneNumber, IDCard)) {
            processRequest(request, response, account);
            return;
        }

        int lecId = 0;
        try {
            lecId = Integer.parseInt(lid);
        } catch (NumberFormatException e) {
            request.setAttribute("Error", "Invalid Lecturer ID.");
            processRequest(request, response, account);
            return;
        }

        LecturerClassSession lcs = new LecturerClassSession();
        if (checkForDuplicates(request, lcs, phoneNumber, email, IDCard, lid)) {
            processRequest(request, response, account);
            return;
        }

        // Update lecturer information
        Lecturers updatedLec = new Lecturers();
        updatedLec.setLid(lecId);
        updatedLec.setLname(lname);
        updatedLec.setGender(gender);
        updatedLec.setDob(dob);
        updatedLec.setPhoneNumber(phoneNumber);
        updatedLec.setIDcard(IDCard);
        updatedLec.setAddress(address);
        updatedLec.setEmail(email);
        updatedLec.setNickname(nickName);

        // Update lecturer in database
        LecturersDBContext lecDB = new LecturersDBContext();
        lecDB.updateLecturer(updatedLec);

        response.sendRedirect("lecturers-profile");
    }

    //check input profile valid
    private boolean checkValidInput(HttpServletRequest request, String lname, String phoneNumber, String IDcard) {
        boolean valid = true;

        if (phoneNumber == null || !phoneNumber.matches("\\d{10}")) {
            request.setAttribute("phoneError", "Invalid phone number. Must be 10 digits !");
            valid = false;
        }

        if (lname == null || !lname.matches("[\\p{L} ]+")) {
            request.setAttribute("nameError", "Invalid name. Please try again !");
            valid = false;
        }

        if (IDcard == null || !IDcard.matches("\\d{12}")) {
            request.setAttribute("idCardError", "Invalid ID Card. Must be 12 digits !");
            valid = false;
        }

        return valid;
    }

    //check if email duplicates
    private boolean checkForDuplicates(HttpServletRequest request, LecturerClassSession lcs, String phoneNumber, String email, String IDcard, String lid) {
        int totalPhoneNumber = lcs.getTotalPhoneNumberExists(phoneNumber, lid);
        int totalIDCard = lcs.getIDCardExists(IDcard, lid);
        int totalEmail = lcs.getEmailExists(email, lid);

        boolean hasDuplicate = false;

        if (totalPhoneNumber > 0) {
            request.setAttribute("phoneError", "Phone number already exists !");
            hasDuplicate = true;
        }

        if (totalEmail > 0) {
            request.setAttribute("emailError", "Email already exists !");
            hasDuplicate = true;
        }

        if (totalIDCard > 0) {
            request.setAttribute("idCardError", "ID card already exists !");
            hasDuplicate = true;
        }

        return hasDuplicate;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating lecturer profiles";
    }
}
