/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package HomePage;

import DAO.AgeDBContext;
import DAO.FoodDBContext;
import DAO.MealTimeDBContext;
import DAO.MenuDBContext;
import Entity.AgeCategory;
import Entity.Food;
import Entity.MealTime;
import Entity.Menu;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name="SearchMenu", urlPatterns={"/searchMenu"})
public class SearchMenu extends HttpServlet {
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchMenu</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchMenu at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String date_raw = request.getParameter("date");
   
        AgeDBContext age = new AgeDBContext();
        List<AgeCategory> listAge = age.getAllAgeCategory();

        MenuDBContext menu = new MenuDBContext();
        List<Menu> listMenu = new ArrayList<>();
        if(date_raw != null){
        listMenu = menu.getMenuByDate(convertToStandardFormat(date_raw));
        }else if(date_raw.isEmpty()){
            response.sendRedirect("menu");
        }
        request.setAttribute("listMenu", listMenu);
        request.setAttribute("date_raw", date_raw);
        request.setAttribute("listAgeCategory", listAge);
        request.getRequestDispatcher("FE_Parent/SearchMenu.jsp").forward(request, response);
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
    
    public String convertToStandardFormat(String dateString) {
        List<String> dateFormats = Arrays.asList(
                "yyyy-MM-dd",
                "dd-MM-yyyy",
                "MM-dd-yyyy",
                "dd/MM/yyyy",
                "MM/dd/yyyy",
                "yyyy/MM/dd",
                "yyyy.MM.dd",
                "dd.MM.yyyy",
                "MM.dd.yyyy"
        );

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (String format : dateFormats) {
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(format);
            try {
                LocalDate date = LocalDate.parse(dateString, inputFormatter);
                return date.format(outputFormatter);
            } catch (DateTimeParseException e) {
                // Ignore and try the next format
            }
        }

        return null; // Nếu không định dạng nào phù hợp
    }

    private final List<DateTimeFormatter> DATE_FORMATTERS = Arrays.asList(
            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
            DateTimeFormatter.ofPattern("dd/MM/yyyy"),
            DateTimeFormatter.ofPattern("MM/dd/yyyy"),
            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd")
    // Add more formats as needed
    );

    public LocalDateTime parseDate(String dateString) {
        for (DateTimeFormatter formatter : DATE_FORMATTERS) {
            try {
                return LocalDate.parse(dateString, formatter).atStartOfDay();
            } catch (DateTimeParseException e) {
                // Continue to next formatter
            }
            try {
                return LocalDateTime.parse(dateString, formatter);
            } catch (DateTimeParseException e) {
                // Continue to next formatter
            }
        }
        throw new IllegalArgumentException("Date format not recognized: " + dateString);
    }

    public int compareDates(String dateStr1, String dateStr2) {
        try {
            LocalDateTime date1 = parseDate(dateStr1);
            LocalDateTime date2 = parseDate(dateStr2);

            return date1.compareTo(date2);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            return 0; // or handle error appropriately
        }
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
