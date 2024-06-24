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

/**
 * Servlet implementation class UpdateLecturers
 */
@WebServlet(name = "UpdateLecturers", urlPatterns = {"/update-lecturers"})
public class UpdateLecturers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LecturerClassSession lcs = new LecturerClassSession();
        String id = request.getParameter("lid");
        Lecturers_Class_Session lec = lcs.getLecturerByid(id);
        request.setAttribute("lec", lec);
        
        Lecturers_Class_Session lec1 = lcs.getLecturerByidClass(id);
        request.setAttribute("lec1", lec1);
        
        ClassDBContext cl = new ClassDBContext();
        List<Class> list = cl.getAllClass();
        request.setAttribute("list1", list);
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

      String referer = request.getHeader("referer");
        response.sendRedirect(referer);

    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating lecturers";
    }
}
