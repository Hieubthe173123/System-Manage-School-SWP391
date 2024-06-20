/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin;

import DAO.CuriculumDBContext;
import DAO.SessionDBContext;
import Entity.Curiculum;
import Entity.Session;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "CuriculumController", urlPatterns = {"/curriculum"})
public class CuriculumController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        SessionDBContext s = new SessionDBContext();
        CuriculumDBContext cur = new CuriculumDBContext();
        
        String sid = request.getParameter("sid");
        String nameAct = request.getParameter("nameAct");
        
        List<Session> list = s.getAllSession();
        request.setAttribute("list", list);

        if (nameAct != null && !nameAct.trim().isEmpty()) {
            List<Curiculum> list2 = cur.SearchByName(sid, nameAct);
            request.setAttribute("list2", list2);
        } else {
            List<Curiculum> list1 = cur.pagingCuriculum(sid);
            request.setAttribute("list1", list1);
        }

        request.getRequestDispatcher("FE_Admin/Curiculum.jsp").forward(request, response);
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
    }
}
