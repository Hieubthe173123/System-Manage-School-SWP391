package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.SchoolYearDBContext;
import Entity.Account;
import Entity.SchoolYear;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "NewSchoolYearController", urlPatterns = {"/admin/newyear"})
public class NewSchoolYearController extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        // Lấy tham số từ request
        String dateStart = request.getParameter("dateStart");
        String dateEnd = request.getParameter("dateEnd");

        try {
            if (dateStart != null && !dateStart.isEmpty() && dateEnd != null && !dateEnd.isEmpty()) {
                // Chuyển đổi chuỗi ngày thành LocalDate
                LocalDate startDate;
                LocalDate endDate;
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    startDate = LocalDate.parse(dateStart, formatter);
                    endDate = LocalDate.parse(dateEnd, formatter);
                } catch (DateTimeParseException e) {
                    // Thông báo lỗi khi định dạng ngày không hợp lệ
                    request.setAttribute("modalError", "Invalid date format! Please use YYYY-MM-DD.");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                    return;
                }

                // Kiểm tra nếu ngày bắt đầu nằm trong quá khứ
                if (startDate.isBefore(LocalDate.now())) {
                    request.setAttribute("modalError", "The start date of the new school year cannot be in the past!");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                    return;
                }

                SchoolYearDBContext yearDB = new SchoolYearDBContext();

                // Kiểm tra nếu năm học đã tồn tại
                if (yearDB.isSchoolYearExists(dateStart, dateEnd)) {
                    request.setAttribute("modalError", "This school year already exists! Please choose another year.");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                } else {
                    // Kiểm tra xem năm học mới có trùng lặp với năm học đã tồn tại không
                    if (yearDB.isOverlapWithExistingSchoolYears(startDate, endDate)) {
                        request.setAttribute("modalError", "The new school year overlaps with an existing school year. Please choose another date range.");
                        request.setAttribute("modalOpen", true);
                        request.getRequestDispatcher("/admin/classController").forward(request, response);
                    } else {
                        // Tạo năm học mới
                        yearDB.createNewSchoolYearForClassSession(dateStart, dateEnd);
                        response.sendRedirect("classController");
                    }
                }
            } else {
                request.setAttribute("modalError", "Start date and end date must not be empty!");
                request.setAttribute("modalOpen", true);
                request.getRequestDispatcher("/admin/classController").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/Error/404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        processRequest(request, response, account);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for creating a new school year";
    }
}
