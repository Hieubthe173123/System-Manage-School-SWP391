/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.Class_SessionDBContext;
import DAO.CuriculumDBContext;
import DAO.SchedulesDBContext;
import DAO.SchoolYearDBContext;
import DAO.SessionDBContext;
import DAO.SessionDetailDBContext;
import Entity.ClassSession;
import Entity.Curiculum;
import Entity.Schedules;
import Entity.SchedulesClone;
import Entity.SchoolYear;
import Entity.SessionDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SchedulesInYear", urlPatterns = {"/schedules"})
public class SchedulesInYear extends HttpServlet {

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
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        SchoolYearDBContext scDb = new SchoolYearDBContext();
        Class_SessionDBContext clasSess = new Class_SessionDBContext();
        SessionDBContext ses = new SessionDBContext();
        CuriculumDBContext cur = new CuriculumDBContext();
        List<Curiculum> curi = cur.getAllCuriculum();
        SessionDetailDBContext sesDe = new SessionDetailDBContext();
        SchedulesDBContext sche = new SchedulesDBContext();

        List<SchedulesClone> listClone = new ArrayList<>();
        List<SessionDetails> list = new ArrayList<>();
        List<ClassSession> listClassSession = new ArrayList<>();

        // Lấy ra năm học hiện tại theo date
        SchoolYear sYear = scDb.getSchoolYearByDateNow(dateF.format(date));

        // Lấy dât được request từ server về       
        String sid = request.getParameter("sid");
        String csid = request.getParameter("csid");

        String yid = request.getParameter("yid");
        // Retrieve parameters from the request
        String[] csidToInsert = {};
        try {
            csidToInsert = request.getParameterValues("csidToInsert");
        } catch (Exception e) {
        }

        String[] sdid = request.getParameterValues("sdid");
        String[] dateInsert = request.getParameterValues("dateInsert");

        // Lấy ra chương trình học của 1 lóp trong 1 năm cũ
        List<Schedules> listSchedules = new ArrayList<>();
        ClassSession s = new ClassSession();

        // Insert schedules if parameters are valid
        if (csidToInsert != null && sdid.length > 0 && dateInsert.length > 0
                && csidToInsert.length == sdid.length && sdid.length == dateInsert.length) {
            /* Insert 1 khung chương trình của 1 lớp học trong 1 năm học
             lấy data sau khi admin nhập dữ liệu*/
            for (int i = 0; i < csidToInsert.length; i++) {
                try {
                    int classSessionId = Integer.parseInt(csidToInsert[i]);
                    int sessionDetailId = Integer.parseInt(sdid[i]);
                    String dateRaw = dateInsert[i];
                    sche.insert(sessionDetailId, dateRaw, classSessionId);

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // Log or handle the case where parameters are not properly matched or null
            System.err.println("Parameters csidToInsert, sdid, and dateInsert are not properly matched or are null");
        }

        try {
            // Lấy ra tất cả các lớp học hiện có trong 1 năm học cụ thể
            listClassSession = clasSess.getClassSessionByYid(Integer.parseInt(yid));
            // Tạo 1 mảng int lưu trữ hết tất cả csid đang có trong list
            int[] csidArrayManual = new int[listClassSession.size()];
            // lấy ra tất cả các csid gán cho mảng
            for (int i = 0; i < listClassSession.size(); i++) {
                csidArrayManual[i] = listClassSession.get(i).getCsid();
            }
            // So sánh csid trong mảng và csid được truyền về từ server và set lại biến flag
            boolean flag = false;
            int csidToCheck = Integer.parseInt(csid);
            for (int id : csidArrayManual) {
                if (id == csidToCheck) {
                    flag = true;
                    break; // Thoát khỏi vòng lặp khi tìm thấy csid
                }
            }
            // Nếu mà csid truyền về khác với csid trong list session class thì sẽ mặc định in ra index 0
            if (flag) {
                listSchedules = sche.getSchedulesByCsid(Integer.parseInt(csid));
            } else {
                listSchedules = sche.getSchedulesByCsid(listClassSession.get(0).getCsid());
            }

            // Lấy ra được chi tiết của 1 classSession gồm bao nhiêu buổi nếu 
            // trường hợp chưa nhập lịch học cho 1 lớp trong năm học này
            if (!csid.isEmpty() || csid != null) {
                s = clasSess.getClassSessionById(Integer.parseInt(csid));
                list = sesDe.getAllSessionDetailBySessionID(s.getSid().getSid());
            }

        } catch (Exception e) {
        }

        request.setAttribute("listSessionDetail", list);
        request.setAttribute("yearNow", sYear);
        request.setAttribute("listYearSchool", scDb.getAllSchoolYear());
        request.setAttribute("listCuri", curi);
        request.setAttribute("sid", sid);
        request.setAttribute("csID", s.getCsid());
        request.setAttribute("yid", yid);
        request.setAttribute("yidRaw", s.getYid());
        request.setAttribute("listSession", listClassSession);
        request.setAttribute("listSchedules", listSchedules);
        
        request.getRequestDispatcher("FE_Parent/SchedulesInYear.jsp").forward(request, response);

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

        request.getRequestDispatcher("FE_Parent/SchedulesInYear.jsp").forward(request, response);
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
