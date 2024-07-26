package Controller.Parent;

import Authentication.BaseRBACController;
import DAO.ParentDBContext;
import Entity.Account;
import Entity.Parent;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "UpdateProfile", urlPatterns = {"/parent/update-profile"})
public class UpdateProfile extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc != null) {
            ParentDBContext parentDB = new ParentDBContext();
            Parent pa = parentDB.getParentByid(acc.getPid().getPid());
            request.setAttribute("pa", pa);

            // Forward to the JSP with the parent data
            request.getRequestDispatcher("/FE_Parent/UpdateProfileParent.jsp").forward(request, response);
        } else {
            // Redirect to login if the user is not authenticated
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc != null) {

            int pid = acc.getPid().getPid();
            String pname = request.getParameter("pname");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String dob = request.getParameter("dob");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String IDcard = request.getParameter("IDcard");
            String nickname = request.getParameter("nickname");


            String errorMessage = null;
            if (phoneNumber == null || !phoneNumber.matches("0\\d{9}")) {
                errorMessage = "Invalid phone number. Please try again.";
            } else if (pname == null || !pname.matches("[\\p{L} ]+")) {
                errorMessage = "Invalid name. Please try again.";
            } else if (IDcard == null || !IDcard.matches("\\d{12}")) {
                errorMessage = "Invalid ID card number. Please try again.";
            }

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                processRequest(request, response, account);
                return;
            }

     
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

   
            ParentDBContext parentDB = new ParentDBContext();

            boolean uniquePhone = parentDB.getTotalPhoneNumberExists(phoneNumber, pid) == 0;
            boolean uniqueEmail = parentDB.getEmailExists(email, pid) == 0;
            boolean uniqueIDCard = parentDB.getIDCardExists(IDcard, pid) == 0;

            if (uniquePhone && uniqueEmail && uniqueIDCard) {
                parentDB.updateParent(parent);
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                if (!uniquePhone) {
                    request.setAttribute("errorMessage", "Phone number already exists.");
                }
                if (!uniqueEmail) {
                    request.setAttribute("errorMessage", "Email already exists.");
                }
                if (!uniqueIDCard) {
                    request.setAttribute("errorMessage", "ID Card already exists.");
                }
            }

        
            processRequest(request, response, account);
        } else {
            
            response.sendRedirect("login");
        }
    }

    @Override
    public String getServletInfo() {
        return "UpdateProfile Servlet";
    }
}