package Controller.Admin;

import DAO.LecturerClassSession;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateLecturerInClass", urlPatterns = {"/update-lecturer-class"})
public class UpdateLecturerInClass extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        String classid = request.getParameter("classid");
        LecturerClassSession lcs = new LecturerClassSession();
        int total = lcs.getTotalLecturerInClass(classid);
        if (total < 5) {
            lcs.updateClass(lid, classid);
            response.sendRedirect("lecturers");
        } else {
            request.setAttribute("errorMessage", "Cannot update class. The class already has 5 lecturers.");
            request.getRequestDispatcher("FE_Admin/UpdateLecturer.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
