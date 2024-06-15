/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.SchoolYearDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author DELL
 */
@WebServlet(name = "NewSchoolYearController", urlPatterns = {"/newyear"})
public class NewSchoolYearController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Lấy tham số dateStart, dateEnd từ request
        String dateStart = request.getParameter("dateStart");
        String dateEnd = request.getParameter("dateEnd");

        try {
            if (dateStart != null && !dateStart.isEmpty() && dateEnd != null && !dateEnd.isEmpty()) {
                SchoolYearDBContext yearDB = new SchoolYearDBContext();

                // Kiểm tra nếu năm học đã tồn tại
                if (yearDB.isSchoolYearExists(dateStart, dateEnd)) {
                    request.setAttribute("err", "Năm học này đã tồn tại! Vui lòng chọn năm học khác.");
                    request.getRequestDispatcher("FE_Admin/NewSchoolYear.jsp").forward(request, response);
                } else {
                    yearDB.createNewSchoolYearForClassSession(dateStart, dateEnd);
                    response.sendRedirect("classController");
                    return;
                }
            } else {
                //request.setAttribute("err", "Ngày bắt đầu và kết thúc không được để trống!");
                request.getRequestDispatcher("FE_Admin/NewSchoolYear.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error/404.jsp");
        }

        //request.getRequestDispatcher("FE_Admin/NewSchoolYear.jsp").forward(request, response);

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
    }// </editor-fold>

}
