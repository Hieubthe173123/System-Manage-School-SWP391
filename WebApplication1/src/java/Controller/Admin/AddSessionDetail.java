package Controller.Admin;

import DAO.SessionDBContext;
import DAO.SessionDetailDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddSessionDetail", urlPatterns = {"/add-session"})
public class AddSessionDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionDBContext s = new SessionDBContext();
        String sid = request.getParameter("sid");
        SessionDetailDBContext sdb = new SessionDetailDBContext();
        int count = sdb.getTotalSession(sid);
        int totalSession = s.SessionNumber(sid);
        if (count < totalSession) {
            sdb.insertSession(sid);
        } else {
            System.out.println("Error: Maximum number of sessions reached.");
        }
        String referer = request.getHeader("referer");
        response.sendRedirect(referer);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}