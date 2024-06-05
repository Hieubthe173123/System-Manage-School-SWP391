package Controller.Admin;

import Entity.Class;
import DAO.ClassDBContext;
import DAO.LecturerClassSession;
import Entity.Lecturers_Class_Session;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddLecturers", urlPatterns = {"/add-lecturer"})
public class AddLecturers extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ClassDBContext cl = new ClassDBContext();
        List<Class> list = cl.getAllLecturersContain();
        request.setAttribute("listA", list);
        request.getRequestDispatcher("FE_Admin/AddLecturer.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Lấy các thông tin từ biểu mẫu
    String lname = request.getParameter("lname");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String phoneNumber = request.getParameter("phoneNumber");
    String email = request.getParameter("email");
    String nickname = request.getParameter("nickname");
    String IDcard = request.getParameter("IDcard");
    String classIDString = request.getParameter("classID");


    LecturerClassSession lcs = new LecturerClassSession();
    lcs.insertLecturers(lname, gender, dob, phoneNumber, IDcard, address, email, nickname, classIDString);
    response.sendRedirect("lecturers");
}


    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
