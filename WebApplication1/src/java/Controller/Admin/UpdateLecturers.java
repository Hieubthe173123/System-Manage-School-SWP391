package Controller.Admin;

import DAO.ClassDBContext;
import DAO.LecturerClassSession;
import DAO.LecturersDBContext;
import Entity.Lecturers;
import Entity.Lecturers_Class_Session;
import Entity.Class;
import Entity.ClassSession;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "UpdateLecturers", urlPatterns = {"/admin/update-lecturers"})
public class UpdateLecturers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String id = request.getParameter("lid");
        if (id == null || id.isEmpty()) {
            request.setAttribute("errorMessage", "Lecturer ID is missing.");
            request.getRequestDispatcher("/FE_Admin/UpdateLecturer.jsp").forward(request, response);
            return;
        }

        LecturerClassSession lcs = new LecturerClassSession();
        Lecturers_Class_Session lec = lcs.getLecturerByid(id);
        request.setAttribute("lec", lec);

        ClassDBContext cl = new ClassDBContext();
        List<ClassSession> list = cl.getAllClass();
        request.setAttribute("list1", list);

        String successMessage = request.getParameter("successMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
        }

        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        request.getRequestDispatcher("/FE_Admin/UpdateLecturer.jsp").forward(request, response);
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
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String IDcard = request.getParameter("IDcard");

        if (!isValidInput(request, lname, phoneNumber, IDcard)) {
            processRequest(request, response);
            return;
        }

        int lid_raw;
        try {
            lid_raw = Integer.parseInt(lid);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid lecturer ID.");
            processRequest(request, response);
            return;
        }

        Lecturers lec = new Lecturers();
        lec.setLid(lid_raw);
        lec.setLname(lname);
        lec.setGender(gender);
        lec.setDob(dob);
        lec.setAddress(address);
        lec.setPhoneNumber(phoneNumber);
        lec.setEmail(email);
        lec.setIDcard(IDcard);

        LecturersDBContext ldb = new LecturersDBContext();
        LecturerClassSession lcs = new LecturerClassSession();

        if (!isDuplicateEntry(request, lcs, phoneNumber, email, IDcard, lid)) {
            ldb.updateLecturers(lec);
            response.sendRedirect("update-lecturers?lid=" + lid + "&successMessage=Lecturer updated successfully.");
        } else {
            processRequest(request, response);
        }
    }

    private boolean isValidInput(HttpServletRequest request, String lname, String phoneNumber, String IDcard) {
        boolean valid = true;

        if (phoneNumber == null || !phoneNumber.matches("0\\d{9}")) {
            request.setAttribute("errorMessage", "Invalid phone number. Please try again.");
            valid = false;
        }

        if (lname == null || !lname.matches("[\\p{L} ]+")) {
            request.setAttribute("errorMessage", "Invalid name. Please try again.");
            valid = false;
        }

        if (IDcard == null || !IDcard.matches("\\d{12}")) {
            request.setAttribute("errorMessage", "Enter invalid information. Please try again.");
            valid = false;
        }

        return valid;
    }

    private boolean isDuplicateEntry(HttpServletRequest request, LecturerClassSession lcs, String phoneNumber, String email, String IDcard, String lid) {
        int totalPhoneNumber = lcs.getTotalPhoneNumberExists(phoneNumber, lid);
        int totalIDCard = lcs.getIDCardExists(IDcard, lid);
        int totalEmail = lcs.getEmailExists(email, lid);

        boolean hasDuplicate = false;

        if (totalPhoneNumber > 0) {
            request.setAttribute("errorMessage", "Phone number already exists.");
            hasDuplicate = true;
        }

        if (totalEmail > 0) {
            request.setAttribute("errorMessage", "Email already exists.");
            hasDuplicate = true;
        }

        if (totalIDCard > 0) {
            request.setAttribute("errorMessage", "ID card already exists.");
            hasDuplicate = true;
        }

        return hasDuplicate;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating lecturers";
    }
}
