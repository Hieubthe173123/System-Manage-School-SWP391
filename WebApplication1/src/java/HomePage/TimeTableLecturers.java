/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.Class_SessionDBContext;
import DAO.CuriculumDBContext;
import DAO.LecturersDBContext;
import DAO.MenuDBContext;
import DAO.SchedulesDBContext;
import DAO.SchoolYearDBContext;
import Entity.ClassSession;
import Entity.Curiculum;
import Entity.Lecturers;
import Entity.Menu;
import Entity.Schedules;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "TimeTableLecturers", urlPatterns = {"/timeTableLecturer"})
public class TimeTableLecturers extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TimeTableLecturers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TimeTableLecturers at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Date date = new Date();
        HttpSession session = request.getSession();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat dateFor = new SimpleDateFormat("dd/MM/yyyy");
        LecturersDBContext lec = new LecturersDBContext();
        SchoolYearDBContext school = new SchoolYearDBContext();
        MenuDBContext menu = new MenuDBContext();
        SchedulesDBContext scheDB = new SchedulesDBContext();
        Class_SessionDBContext classSession = new Class_SessionDBContext();
        List<Menu> menuInDay = new ArrayList<>();
        SchedulesDBContext sche = new SchedulesDBContext();

        CuriculumDBContext cur = new CuriculumDBContext();
        List<Curiculum> curi = cur.getAllCuriculum();
        ClassSession listClass = new ClassSession();
        String lid_raw = request.getParameter("lid");
        if ((!lid_raw.isEmpty() || lid_raw != null) && school.getSchoolYearByDateNow(dateF.format(date)) != null) {
            listClass = classSession.getClassSessionByLidAndDateNow(Integer.parseInt(lid_raw), school.getSchoolYearByDateNow(dateF.format(date)).getYid());
            if (listClass != null ) {
                List<Schedules> listSchedulesUnlearn = sche.getAllUnclassifiedSessionsDetail(listClass.getCsid());             
                Schedules schedules = scheDB.getSchedulesByCsIdAndDate(listClass.getCsid(), dateF.format(date));
                if (!listSchedulesUnlearn.isEmpty() && schedules == null) {
                    sche.insert(listSchedulesUnlearn.get(0).getSdid().getSdid(), dateF.format(date), listClass.getCsid());
                }
                session.setAttribute("lid", Integer.parseInt(lid_raw));
                session.setAttribute("csid", listClass.getCsid());
                Lecturers lectu = lec.getLecturerByid(Integer.parseInt(lid_raw));
                request.setAttribute("infoLecturer", lectu);
                request.setAttribute("curi", curi);
                request.setAttribute("dateNow", dateFor.format(date));
                menuInDay = menu.getMenuByAgeAndDate(listClass.getSid().getAge().getAgeid(), dateF.format(date));           
                Schedules schedules2 = scheDB.getSchedulesByCsIdAndDate(listClass.getCsid(), dateF.format(date));
                if (schedules2 != null) {
                    request.setAttribute("schedulesToDay", schedules2);
                }
                if (menuInDay != null) {
                    request.setAttribute("menu", menuInDay);
                }
                request.getRequestDispatcher("FE_Lecturers/TimeTableLecturer.jsp").forward(request, response);
            }

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
