package controller.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import util.MailConfig;

@WebServlet("/member/sendEmailCode")
public class SendEmailController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");

        if (!MailConfig.isConfigured()) {
            resp.getWriter().write("{\"success\":false,\"message\":\"mail not configured\"}");
            return;
        }

        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = req.getReader()) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        }

        String email = new JSONObject(sb.toString()).getString("email");

        String code = String.valueOf((int) (Math.random() * 900000) + 100000);

        HttpSession session = req.getSession();
        session.setAttribute("authCode", code);
        session.setAttribute("authTime", System.currentTimeMillis());
        session.setAttribute("authEmail", email);

        try {
            Properties prop = new Properties();
            prop.put("mail.smtp.host", MailConfig.getSmtpHost());
            prop.put("mail.smtp.port", MailConfig.getSmtpPort());
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getInstance(prop, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(MailConfig.getUsername(), MailConfig.getAppPassword());
                }
            });

            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(MailConfig.getUsername()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("핏츠버그 인증코드");
            message.setText("인증코드: " + code);

            Transport.send(message);
            resp.getWriter().write("{\"success\":true}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\":false}");
        }
    }
}
