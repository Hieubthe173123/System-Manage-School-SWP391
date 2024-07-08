/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.FoodDBContext;
import Entity.Food;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author hidung
 */
@WebServlet(name = "AddFood", urlPatterns = {"/add-food"})
public class AddFood extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddFood</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddFood at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            String fname = request.getParameter("fname");
            // Kiểm tra nếu calo là số nguyên hợp lệ           

            // Tạo đối tượng food mới
            Food newFood = new Food();
            newFood.setFname(fname);
            // Kiểm tra xem món ăn đã tồn tại hay chưa
            FoodDBContext foodDBContext = new FoodDBContext();
            if (foodDBContext.foodExists(fname)) {
                request.setAttribute("errorMessage", "Food already exists.");
                request.getRequestDispatcher("/food").forward(request, response);
                return;
            }
            // Lưu đối tượng food mới vào cơ sở dữ liệu
            foodDBContext.addFood(newFood);
            // Chuyển hướng tới trang Admin_Food.jsp
            request.getRequestDispatcher("/food").forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi khác
            request.setAttribute("errorMessage", "An error occurred while adding food.");
            request.getRequestDispatcher("/food").forward(request, response);
        }
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
