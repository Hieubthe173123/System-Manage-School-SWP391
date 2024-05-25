package HomePage;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import DAO.CuriculumDBContext;
import DAO.FeedbackDBContext;
import DAO.MenuDBContext;
import DAO.SchedulesDBContext;
import DAO.StudentClassSessionDBContext;
import DAO.StudentDBContext;
import Entity.Curiculum;
import Entity.Feedback;
import Entity.Menu;
import Entity.Schedules;
import Entity.StudentClassSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns={"/timetable"})
public class TimeTable extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        StudentClassSessionDBContext studen = new StudentClassSessionDBContext();
        StudentDBContext students = new StudentDBContext();
        SchedulesDBContext sche = new SchedulesDBContext();
        CuriculumDBContext curiculum = new CuriculumDBContext();
        MenuDBContext menu = new MenuDBContext();
        String stuid = request.getParameter("stuid");
        HttpSession session = request.getSession();
        int role = (int) session.getAttribute("role");
        if(role == 1){
            Date date = new Date();
            SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
            FeedbackDBContext feed = new FeedbackDBContext();
            List<StudentClassSession> list = studen.getStudentClassSessionByStuid(Integer.parseInt(stuid));
            int classI = 0;
            for (StudentClassSession x : list) {
                classI = x.getCsid().getCsid();
            }
            // Lấy ra ngày hiện tại và lớp học
            Schedules schedules = sche.getSchedulesByCsIdAndDate(classI, dateF.format(date));
            List<Curiculum> curi = curiculum.getCuriculumById(schedules.getSdid().getSdid());
            Feedback f = feed.getFeedbackByIdAndate(dateF.format(date), Integer.parseInt(stuid));
            List<Menu> m = menu.getMenuByAgeAndDate(classI, dateF.format(date));
            request.setAttribute("curiculum", curi);
            request.setAttribute("feedback", f);
            request.setAttribute("menu", m);
            request.setAttribute("student", students.getStudentById(Integer.parseInt(stuid)));
            request.getRequestDispatcher("FE_Parent/TimeTable.jsp").forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
