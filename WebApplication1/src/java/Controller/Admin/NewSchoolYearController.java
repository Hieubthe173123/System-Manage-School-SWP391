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
        // Get parameters from the request
        String dateStart = request.getParameter("dateStart");
        String dateEnd = request.getParameter("dateEnd");

        try {
            if (dateStart != null && !dateStart.isEmpty() && dateEnd != null && !dateEnd.isEmpty()) {
                //Chuyển đổi ngày tháng dạng chuỗi sang LocalDate
                LocalDate startDate;
                LocalDate endDate;
                try {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    startDate = LocalDate.parse(dateStart, formatter);
                    endDate = LocalDate.parse(dateEnd, formatter);
                } catch (DateTimeParseException e) {
                    //Sai định dạng thông báo lỗi
                    request.setAttribute("modalError", "Invalid date format! Please use YYYY-MM-DD.");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                    return;
                }

                // kiểm tra nếu năm học được tạo là năm học trong quá khứ
                if (startDate.isBefore(LocalDate.now())) {
                    request.setAttribute("modalError", "The start date of the new school year cannot be in the past!");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                    return;
                }

                SchoolYearDBContext yearDB = new SchoolYearDBContext();

                // Kiểm tra nếu năm học đó đã tồn tại
                if (yearDB.isSchoolYearExists(dateStart, dateEnd)) {
                    request.setAttribute("modalError", "This school year already exists! Please choose another year.");
                    request.setAttribute("modalOpen", true);
                    request.getRequestDispatcher("/admin/classController").forward(request, response);
                } else {
                    // Check that the new school year is at least one year apart from the last year
                    SchoolYear latestYear = yearDB.getNewestSchoolYear();

                    if (latestYear != null) {
                        // Năm học mới được tạo phải cách năm học cũ ít nhất 1 năm
                        int latestYearEnd = Integer.parseInt(latestYear.getDateEnd().substring(0, 4));
                        int newYearStart = Integer.parseInt(dateStart.substring(0, 4));
                        int newYearEnd = Integer.parseInt(dateEnd.substring(0, 4));

                        // Năm học mới được tạo phải nối tiếp năm học cũ
                        if (newYearStart == latestYearEnd && newYearEnd == newYearStart + 1) {
                            // Tạo năm học mới
                            yearDB.createNewSchoolYearForClassSession(dateStart, dateEnd);
                            response.sendRedirect("classController");
                        } else {
                            request.setAttribute("modalError", "The new school year must directly follow the latest school year (e.g., 2023-2024 to 2024-2025).");
                            request.setAttribute("modalOpen", true);
                            request.getRequestDispatcher("/admin/classController").forward(request, response);
                        }
                    } else {
                        // nếu không có năm học nào trước đó thì tạo năm học mới trực tiếp
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
        return "Short description";
    }// </editor-fold>
}
