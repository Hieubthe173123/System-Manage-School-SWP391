package HomePage;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import DAO.Class_SessionDBContext;
import DAO.CuriculumDBContext;
import DAO.FeedbackDBContext;
import DAO.MenuDBContext;
import DAO.SchedulesDBContext;
import DAO.SchoolYearDBContext;
import DAO.StudentClassSessionDBContext;
import DAO.StudentDBContext;
import Entity.Curiculum;
import Entity.Feedback;
import Entity.Menu;
import Entity.Schedules;
import Entity.SchoolYear;
import Entity.Student;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/timetable"})
public class TimeTable extends HttpServlet {

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
        HttpSession session = request.getSession();
        StudentClassSessionDBContext studen = new StudentClassSessionDBContext();
        StudentDBContext students = new StudentDBContext();
        SchedulesDBContext sche = new SchedulesDBContext();
        CuriculumDBContext curiculum = new CuriculumDBContext();
        MenuDBContext menu = new MenuDBContext();
        Class_SessionDBContext clSes = new Class_SessionDBContext();
        List<Curiculum> curi = new ArrayList<>();
        int stuid = Integer.parseInt(request.getParameter("stuid"));
        String yidHistory = request.getParameter("yidHistoty");
        String schedulesID = request.getParameter("schedulesID");
        SchoolYearDBContext school = new SchoolYearDBContext();
        Date date = new Date();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        FeedbackDBContext feed = new FeedbackDBContext();

        SchoolYear sch = school.getSchoolYearByDateNow(dateF.format(date));
        // Lấy ra tất cả năm học của 1 học sinh đã học
        List<StudentClassSession> listYidInHistory = studen.getStudentClassSessionById(stuid);

        // Lấy ra ngày học trong 1 năm học dựa trên yid và studentID được gửi từ về
        StudentClassSession stuClassSession = new StudentClassSession();
        List<Schedules> listSch = new ArrayList<>();
//        if (yidHistory != null) {
//            stuClassSession = studen.getStudentClassSessionByStuid(stuid, Integer.parseInt(yidHistory));
//            listSch = sche.getSchedulesByCsid(stuClassSession.getCsid().getCsid());
//            request.setAttribute("yidH", Integer.parseInt(yidHistory));
//        } else {
//            listSch = sche.getSchedulesByCsid(listYidInHistory.get(0).getCsid().getCsid());
//            request.setAttribute("yidH", Integer.parseInt(yidHistory));
//        }
        if (yidHistory != null) {
            stuClassSession = studen.getStudentClassSessionByStuid(stuid, Integer.parseInt(yidHistory));
            listSch = sche.getSchedulesByCsid(stuClassSession.getCsid().getCsid());
            request.setAttribute("yidH", Integer.parseInt(yidHistory));
        } else if(yidHistory == null && sch != null){
            stuClassSession = studen.getStudentClassSessionByStuid(stuid, sch.getYid());
            listSch = sche.getSchedulesByCsid(stuClassSession.getCsid().getCsid());
            request.setAttribute("yidH", sch.getYid());
        }else{
             listSch = sche.getSchedulesByCsid(listYidInHistory.get(0).getCsid().getCsid());
            request.setAttribute("yidH", Integer.parseInt(yidHistory));
        }

        StudentClassSession studID = studen.getStudentClassSessionByStuid(stuid, sch.getYid());

        int role = (int) session.getAttribute("role");
        int pid = (int) session.getAttribute("pid");
        List<Student> listStudentByPid = students.getStudentByPid(pid);

        if (role == 1) {

            int classI = studID.getCsid().getCsid();
            // Lấy ra ngày hiện tại và lớp học

            Schedules schedules = sche.getSchedulesByCsIdAndDate(classI, dateF.format(date));
            try {
                if (schedulesID != null && !schedulesID.equals("0")) {
                    Schedules sc = sche.getSchedulesBySchedulesID(Integer.parseInt(schedulesID));
                    curi = curiculum.getCuriculumById(sc.getSdid().getSdid());
                    request.setAttribute("schID", Integer.parseInt(schedulesID));
                } else {
                    curi = curiculum.getCuriculumById(schedules.getSdid().getSdid());
                }

            } catch (Exception e) {
            }
            List<Menu> menuInDay = new ArrayList<>();
            Feedback f = feed.getFeedbackByIdAndate(dateF.format(date), stuid);
            if (schedulesID != null && !schedulesID.equals("0")) {
                Schedules sc = sche.getSchedulesBySchedulesID(Integer.parseInt(schedulesID));
                menuInDay = menu.getMenuByAgeAndDate(sc.getCsid().getSid().getAge().getAgeid(), sc.getDate().toString());
                request.setAttribute("schID", Integer.parseInt(schedulesID));
            } else {
                menuInDay = menu.getMenuByAgeAndDate(clSes.getClassSessionById(classI).getSid().getAge().getAgeid(), dateF.format(date));
            }
            request.setAttribute("curiculum", curi);
            request.setAttribute("feedback", f);
            request.setAttribute("pid", pid);
            request.setAttribute("menu", menuInDay);
            request.setAttribute("list", listStudentByPid);
            request.setAttribute("listSch", listSch);
            request.setAttribute("role", role);
            session.setAttribute("studenId", stuid);
            request.setAttribute("listYidInHistory", listYidInHistory);
            request.setAttribute("student", students.getStudentById(stuid));
            request.getRequestDispatcher("FE_Parent/TimeTable.jsp").forward(request, response);
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
