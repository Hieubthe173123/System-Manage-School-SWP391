package Controller.Admin;

import Authentication.BaseRBACController;
import DAO.CuriculumDBContext;
import Entity.Account;
import Entity.Curiculum;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@WebServlet(name = "AddCuriculum", urlPatterns = {"/admin/add-curiculum"})
public class AddCuriculum extends BaseRBACController {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        String sid = request.getParameter("sid");
        String sdid = request.getParameter("sdid");

        CuriculumDBContext cur = new CuriculumDBContext();
        List<Curiculum> list = cur.getAllActivityInSession(sid, sdid);

        request.setAttribute("list", list);
        request.getRequestDispatcher("/FE_Admin/AddCuriculum.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        try {
            String nameAct = request.getParameter("nameAct");
            String sdid = request.getParameter("sdid");
            String isFix = request.getParameter("isFix");
            String timeSlot = request.getParameter("timeSlot");

            String[] times = timeSlot.split("-");
            String timeStart = times[0].trim();
            String timeEnd = times[1].trim();

            CuriculumDBContext cur = new CuriculumDBContext();

            boolean conflict = cur.checkTimeSlotConflict(sdid, timeStart, timeEnd);

            HttpSession session = request.getSession();

            if (conflict) {
                session.setAttribute("message", "Khung giờ học đã có.");
                session.setAttribute("messageType", "error");
            } else {
                cur.addCuriculum(nameAct, sdid, isFix, timeStart, timeEnd);
                session.setAttribute("message", "Thêm thành công");
                session.setAttribute("messageType", "success");
            }

            // Lấy URL referer
            String referer = request.getHeader("referer");
            String redirectUrl = referer + (referer.contains("?") ? "&" : "?") + "sid=" + request.getParameter("sid") + "&sdid=" + sdid;

            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi. Vui lòng thử lại.");
            request.getRequestDispatcher("/FE_Admin/AddCuriculum.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
