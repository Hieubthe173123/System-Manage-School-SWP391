package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.ClassDBContext;
import DAO.LecturerClassSession;
import Entity.Account;
import Entity.ClassSession;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddLecturers", urlPatterns = {"/admin/add-lecturer"})
public class AddLecturers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ClassDBContext cl = new ClassDBContext();
        List<ClassSession> list = cl.getAllClass();
        request.setAttribute("listA", list);
        request.getRequestDispatcher("/FE_Admin/AddLecturer.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String lname = request.getParameter("lname");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dob");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String IDcard = request.getParameter("IDcard");
            String classID = request.getParameter("classID");

            LecturerClassSession lcs = new LecturerClassSession();
            boolean isNumberPhone = lcs.isPhoneNumberExists(phoneNumber);
            boolean isIDCard = lcs.isIDCardExists(IDcard);
            boolean isEmail = lcs.isEmailExits(email);

            if (isNumberPhone) {
                request.setAttribute("errorMessage", "The phone number already exists. Please try again.");
                processRequest(request, response);
                return;
            }

            if (isIDCard) {
                request.setAttribute("errorMessage", "The ID card number already exists. Please try again.");
                processRequest(request, response);
                return;
            }

            if (isEmail) {
                request.setAttribute("errorMessage", "The email already exists. Please try again.");
                processRequest(request, response);
                return;
            }

            if (phoneNumber == null || !phoneNumber.matches("0\\d{9}")) {
                request.setAttribute("errorMessage", "Invalid phone number. Please try again.");
                processRequest(request, response);
                return;
            }

            if (lname == null || !lname.matches("[\\p{L} ]+")) {
                request.setAttribute("errorMessage", "Invalid name. Please try again.");
                processRequest(request, response);
                return;
            }

            if (IDcard == null || !IDcard.matches("\\d{12}")) {
                request.setAttribute("errorMessage", "The ID card number must consist of exactly 12 digits.");
                processRequest(request, response);
                return;
            }

            int total = lcs.getTotalLecturerInClass(classID);
            if (total < 5) {
                lcs.addLecturer(lname, gender, dob, phoneNumber, IDcard, address, email, classID);
                response.sendRedirect("lecturers");
            } else {
                request.setAttribute("errorMessage", "This class already has 4 lecturers.");
                processRequest(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("/Error/404.jsp").forward(request, response);
            return;
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
