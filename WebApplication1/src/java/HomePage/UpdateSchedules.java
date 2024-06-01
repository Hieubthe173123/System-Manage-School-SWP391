/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.Class_SessionDBContext;
import DAO.CuriculumDBContext;
import DAO.SchedulesDBContext;
import DAO.SchoolYearDBContext;
import DAO.SessionDetailDBContext;
import Entity.ClassSession;
import Entity.Curiculum;
import Entity.Schedules;
import Entity.SchoolYear;
import Entity.SessionDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateSchedules", urlPatterns = {"/updateSchedules"})
public class UpdateSchedules extends HttpServlet {

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
        Date date = new Date();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        SchoolYearDBContext scDb = new SchoolYearDBContext();
        // Lấy ra năm học hiện tại theo date
        SchoolYear sYear = scDb.getSchoolYearByDateNow(dateF.format(date));
        String csid = request.getParameter("csid");
        String dateUpdate = request.getParameter("dateUpdate");
        String sdid = request.getParameter("sdid");
        String yid = request.getParameter("yid");
        SchedulesDBContext sche = new SchedulesDBContext();
        Class_SessionDBContext clasSess = new Class_SessionDBContext();
        CuriculumDBContext cur = new CuriculumDBContext();
        SessionDetailDBContext sesDe = new SessionDetailDBContext();
        HttpSession session = request.getSession();
        ClassSession s = clasSess.getClassSessionById(Integer.parseInt(csid));
        List<SessionDetails> listSessionDetail = sesDe.getAllSessionDetailBySessionID(s.getSid().getSid());
        List<Curiculum> curi = cur.getAllCuriculum();
        
        if(dateUpdate != null && !dateUpdate.isEmpty() && sdid != null && csid != null){
            sche.update(dateUpdate, Integer.parseInt(sdid), Integer.parseInt(csid));
        }else if(dateUpdate != null){
            request.setAttribute("mess", "Bạn chưa nhập ngày cho việc update");
        }
        List<Schedules> listSchedules = sche.getSchedulesByCsid(Integer.parseInt(csid));
        request.setAttribute("listSessionDetail", listSessionDetail);
        request.setAttribute("listCuri", curi);
        request.setAttribute("csID", s.getCsid());
        request.setAttribute("classSession", s);
        request.setAttribute("listSchedules", listSchedules);
        request.setAttribute("csID", csid);

        session.setAttribute("yidRaw", sYear);
        request.getRequestDispatcher("FE_Parent/UpdateSchedules.jsp").forward(request, response);
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
        processRequest(request, response);
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
