package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.SessionDBContext;
import DAO.SessionDetailDBContext;
import Entity.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddSessionDetail", urlPatterns = {"/admin/add-session"})
public class AddSessionDetail extends BaseRBACController {

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
         SessionDBContext s = new SessionDBContext();
        String sid = request.getParameter("sid");
        SessionDetailDBContext sdb = new SessionDetailDBContext();
        int count = sdb.getTotalSession(sid);
        int totalSession = s.SessionNumber(sid);
        HttpSession session = request.getSession();

        if (count < totalSession) {
            sdb.insertSession(sid);
            // Redirect to the referer URL
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        } else {
            // Set the error message in session and redirect back to referer
            String errorMessage = "Error: Maximum number of sessions reached.";
            session.setAttribute("errorMessage", errorMessage);
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}