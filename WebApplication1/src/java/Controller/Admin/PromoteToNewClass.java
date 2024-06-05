/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.Class_SessionDBContext;
import DAO.SchoolYearDBContext;
import DAO.StudentDBContext;
import Entity.ClassSession;
import Entity.SchoolYear;
import Entity.StudentClassSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
@WebServlet(name = "PromoteToNewClass", urlPatterns = {"/promote"})
public class PromoteToNewClass extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Tạo 1 session mới để lưu trữ thông tin
        HttpSession session = request.getSession();
        //gọi đối tượng DBContext để tương tác
        SchoolYearDBContext db = new SchoolYearDBContext();
        
        //Lấy danh sách tất cả các năm học , lưu vào session
        ArrayList<SchoolYear> listYear = db.getAllSchoolYear();
        session.setAttribute("listYear", listYear);
        
         // Lấy tham số yid và newCsid từ request
        String yid = request.getParameter("yid");
        String newCsid = request.getParameter("newCsid");
        try {
            //khi ấn submit để insert sẽ gọi đến hàm POST
            if (request.getMethod().equalsIgnoreCase("POST")) {
                //Tạo 1 mảng rỗng để lưu các học sinh đã chọn để lưu vào lớp mới 
                String[] selectedStudents = request.getParameterValues("selectedStudents");

                //Nếu có học sinh được chọn
                if (selectedStudents != null) {
                    for (String studentID : selectedStudents) {

                        StudentDBContext studb = new StudentDBContext();
                        Class_SessionDBContext clsdb = new Class_SessionDBContext();

                        //Tạo StudentClassSession để lưu thông tin học sinh và lớp học
                        StudentClassSession studentClassSession = new StudentClassSession();
                        studentClassSession.setStuid(studb.getStudentById(Integer.parseInt(studentID)));
                        studentClassSession.setCsid(clsdb.getClassSessionById(Integer.parseInt(newCsid)));
                        //Thêm học sinh vào lớp mới
                        db.addStudentToClass(studentClassSession);

                    }
                }else{
                    request.setAttribute("err", "you need choose Student to add !!!");
                }
                response.sendRedirect("promote?yid=" + yid + "&newCsid=" + newCsid);
                return;
            }

            //Nếu yid không null, hiển thị thông tin của năm học đó
            if (yid != null) {
                ArrayList<ClassSession> listClassSession = db.getClassSessionByYid(yid);
                session.setAttribute("listClassSession", listClassSession);

                //Lấy ra các năm học dựa theo id
                ArrayList<SchoolYear> selectedYear = db.getSchoolYearById(yid);
                session.setAttribute("selectedYear", selectedYear);
                
                //kiểm tra xem sinh viên đó đã đăng ký học lớp nào trong năm học đó
                ArrayList<StudentClassSession> assignedStudents = db.getAssignedStudentId(yid);
                session.setAttribute("assignedStudents", assignedStudents);

                // Nếu có lớp mới được chọn, lấy danh sách học sinh của năm học cũ để thêm vào lớp mới
                if (newCsid != null && !newCsid.isEmpty()) {
                    ArrayList<StudentClassSession> studentClassSessionOldYear = db.getStudentsFromPreviousYears(yid);
                    session.setAttribute("studentClassSessionOldYear", studentClassSessionOldYear);
                }
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ
            System.out.println(e);
            response.sendRedirect("Error/404.jsp");
            return;
        }

        request.getRequestDispatcher("FE_Admin/PromoteStudent.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
