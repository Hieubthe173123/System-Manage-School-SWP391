/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package HomePage;

import DAO.AccountDBContext;
import DAO.LecturersDBContext;
import DAO.ParentDBContext;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.util.Properties;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/forgot"})
public class ForgotPassword extends HttpServlet {

    // Method to generate a random password
    private String generateRandomPassword(int length) {
        final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            password.append(chars.charAt(random.nextInt(chars.length())));
        }
        return password.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("FE_Parent/ForgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve email parameter
        String email = request.getParameter("mailForgot");
        LecturersDBContext lec = new LecturersDBContext();
        ParentDBContext par = new ParentDBContext();
        AccountDBContext acc = new AccountDBContext();

        if (lec.getLecturerByEmail(email) == null && par.getParentByGmail(email) == null) {
            request.setAttribute("err", "Email bạn nhập đã sai hoặc không tồn tại!");
            request.getRequestDispatcher("FE_Parent/ForgotPassword.jsp").forward(request, response);
            return;
        } else {
            // Generate a random password
            String randomPassword = generateRandomPassword(10);

            // Update the password in the database
            if (lec.getLecturerByEmail(email) != null) {
                acc.updatePasswordByLecturerEmail(email, randomPassword);
            } else if (par.getParentByGmail(email) != null) {
                acc.updatePasswordByParentEmail(email, randomPassword);
            }

            // Create email content
            String content = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "<head>\n"
                    + "    <title>Email</title>\n"
                    + "    <style>\n"
                    + "        body { font-family: Arial, sans-serif; }\n"
                    + "        .container { padding: 20px; }\n"
                    + "        .header { background-color: #f4f4f4; padding: 10px; text-align: center; }\n"
                    + "        .content { margin-top: 20px; }\n"
                    + "        .footer { margin-top: 20px; text-align: center; font-size: 12px; color: #777; }\n"
                    + "    </style>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "    <div class='container'>\n"
                    + "        <div class='header'>\n"
                    + "            <h1>Hello Parent!</h1>\n"
                    + "        </div>\n"
                    + "        <div class='content'>\n"
                    + "            <p>Your new password is generated below:</p>\n"
                    + "            <p><strong>" + randomPassword + "</strong></p>\n"
                    + "        </div>\n"
                    + "        <div class='footer'>\n"
                    + "            <p>&copy; 2024 Sakura School. Make your best day</p>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";

            // Configure Properties
            final String user = "kienpdhe170155@fpt.edu.vn";
            final String pass = "lrrq jpje rszs cann";
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Create a session to send mail
            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, pass);
                }
            });

            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(user));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Your New Password");
                message.setContent(content, "text/html");
                Transport.send(message);
                request.setAttribute("mailStatus", "success");
            } catch (MessagingException e) {
                e.printStackTrace();
                request.setAttribute("mailStatus", "error");
            }
            //sendEmail(email, request, response);
            request.setAttribute("confirm", "Mật khẩu đã được gửi qua email. Vui lòng kiểm tra email!");
            request.getRequestDispatcher("FE_Parent/ForgotPassword.jsp").forward(request, response);
        }
    }
}
