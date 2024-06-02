package Controller.Admin;

import DAO.LecturersDBContext;
import DAO.ParentDBContext;
import Entity.Lecturers;
import Entity.Parent;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "UpdateLecturers", urlPatterns = {"/update-lecturers"})
public class UpdateLecturers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LecturersDBContext ldb = new LecturersDBContext();
        String id = request.getParameter("lid");
        Lecturers lec = ldb.getLecturerById(id);
        request.setAttribute("lec", lec);
        request.getRequestDispatcher("FE_Admin/UpdateLecturer.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int lid_raw = 0;
        
        String lid = request.getParameter("lid");
        String lname = request.getParameter("lname");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String IDcard = request.getParameter("IDcard");
       
        try {
            lid_raw = Integer.parseInt(lid);
        } catch (Exception e) {
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
        ldb.updateLecturers(lec);

        response.sendRedirect("lecturers");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating lecturers";
    }
}
