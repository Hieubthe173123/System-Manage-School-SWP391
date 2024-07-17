package Controller.Lecturers;

import Authentication.BaseRBACController;
import DAO.FeedbackDBContext;
import DAO.LecturerClassSession;
import DAO.StudentDBContext;
import Entity.Account;
import Entity.Feedback;
import Entity.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "Addfeedback", urlPatterns = {"/lecturers/feedback"})
public class Addfeedback extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {   
        processRequest(request, response, account);
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
        throws ServletException, IOException {
    String action = request.getParameter("action");
        String ftitle = request.getParameter("ftitle");
        String fcontent = request.getParameter("fcontent");
        String dateFeedback = request.getParameter("dateFeedback");
        String lecturerId = request.getParameter("lid");

        FeedbackDBContext feedbackDB = new FeedbackDBContext();
        StudentDBContext studentDB = new StudentDBContext();

        if (action != null && !action.isEmpty()) {
            if ("singleStudent".equals(action)) {
                String studentIdParam = request.getParameter("studentId");
                if (studentIdParam != null && !studentIdParam.isEmpty()) {
                    try {
                        int studentId = Integer.parseInt(studentIdParam);
                        Student student = studentDB.getStudentById(studentId);
                        Date feedbackDate = Date.valueOf(dateFeedback);
                        if (!feedbackDB.feedbackExists(studentId, feedbackDate)) {
                            Feedback fb = new Feedback();
                            fb.setFtitle(ftitle);
                            fb.setFcontent(fcontent);
                            fb.setDateFeedback(feedbackDate);
                            fb.setStuid(student);
                            feedbackDB.addFeedback(fb);
                        }else{
                            request.setAttribute("errorMessage", "Feedback already exists, you can just edit or delete it.");
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        // Handle the case where studentId is not a valid integer
                    }
                }
            } else if ("allStudents".equals(action)) {
                if (lecturerId != null && !lecturerId.isEmpty()) {
                    try {
                        int lecturerIdInt = Integer.parseInt(lecturerId);
                        LecturerClassSession lecClassSessionDB = new LecturerClassSession();
                        List<Student> studentList = lecClassSessionDB.getStudentsForLecturers(lecturerIdInt);
                        Date feedbackDate = Date.valueOf(dateFeedback);
                        for (Student student : studentList) {
                            if (!feedbackDB.feedbackExists(student.getStuid(), feedbackDate)) {
                                Feedback fb = new Feedback();
                                fb.setFtitle(ftitle);
                                fb.setFcontent(fcontent);
                                fb.setDateFeedback(feedbackDate);
                                fb.setStuid(student);
                                feedbackDB.addFeedback(fb);
                            }else{
                                request.setAttribute("errorMessage", "Feedback already exists, you can just edit or delete it.");
                            }
                        }
                    } catch (NumberFormatException e) {
                    }
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/lecturers/list-feedback?lecturerId=" + lecturerId + "&dateFeedback=" + dateFeedback);
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
