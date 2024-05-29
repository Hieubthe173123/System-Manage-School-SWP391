package Controller.Admin;

import DAO.LecturerClassSession;
import DAO.LecturersDBContext;
import DAO.SchoolYearDBContext;
import Entity.Lecturers_Class_Session;
import Entity.SchoolYear;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LecturersController", urlPatterns = {"/lecturers"})
public class LecturersController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        SchoolYearDBContext sy = new SchoolYearDBContext();
        LecturerClassSession lcs = new LecturerClassSession();
        LecturersDBContext ldb = new LecturersDBContext();
        String timeStart = request.getParameter("timeStart");
        String timeEnd = request.getParameter("timeEnd");
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);
        int count = ldb.getTotalLecturers();
        int endPage = count / 10; 
        if (count % 10 != 0) {
            endPage++;
        }

        if (timeStart != null && timeEnd != null) {
            List<Lecturers_Class_Session> list3 = lcs.getAllLecturerBySchoolYear(timeStart, timeEnd);
            request.setAttribute("listC",list3);
        }else {
        List<Lecturers_Class_Session> list1 = lcs.pagingLecturers(index);
        request.setAttribute("listA", list1);
        }
        List<SchoolYear> list2 = sy.getAllSchoolYear();
        
        request.setAttribute("listB", list2);
        
        request.setAttribute("endPage", endPage);
        request.setAttribute("index", index);
        request.getRequestDispatcher("FE_Admin/CRUD_Lecturers.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
