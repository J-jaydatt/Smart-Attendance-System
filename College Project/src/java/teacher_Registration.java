import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet(urlPatterns = {"/teacher"})
public class teacher_Registration extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        Connection c1 = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        int sRollNo = 0;

        try {
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/myProject", "root", "root1234");

            // Find the max tId from the teacher table
            String q1 = "SELECT MAX(tId) FROM teacher";
            pst = c1.prepareStatement(q1);
            rs = pst.executeQuery();
            if (rs.next()) {
                sRollNo = rs.getInt(1) + 55;
            }

            // Get parameters from the form
            String sName = request.getParameter("teacher_Name");
            String sGender = request.getParameter("teacher_Gender");
            String sContact = request.getParameter("teacher_Contact");
            final String sEmail = request.getParameter("teacher_Email");

            // Generate a temporary password
            String tempPassword = "Tea@" + (int) (Math.random() * 1244);

            // Insert teacher data into the database
            String sql = "INSERT INTO teacher (tId, tName, tGender, tContact, tEmail, tPassword) VALUES (?, ?, ?, ?, ?, ?)";
            pst = c1.prepareStatement(sql);
            pst.setInt(1, sRollNo);
            pst.setString(2, sName);
            pst.setString(3, sGender);
            pst.setString(4, sContact);
            pst.setString(5, sEmail);
            pst.setString(6, tempPassword);
            pst.executeUpdate();

            // Email Configuration
            final String admin_Email = "acollege074@gmail.com";
            final String admin_Password = "ecmwfdhsqbywdbre";
            String host = "smtp.gmail.com";

            Properties prop = new Properties();
            prop.put("mail.smtp.host", host);
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");

            // Create mail session
            Session mailSession = Session.getInstance(prop, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(admin_Email, admin_Password);
                }
            });

            // Create the email
            MimeMessage msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(admin_Email));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(sEmail));
            msg.setSubject("Welcome to Smart Attendance - Registration Successful");
            msg.setText("Hello " + sName + ",\n\n" +
                        "Your registration was successful! Below are your credentials:\n\n" +
                        "Teacher ID: " + sRollNo + "\n" +
                        "Temporary Password: " + tempPassword + "\n\n" +
                        "Please log in and change your password immediately.\n\n" +
                        "Best regards,\nSmart Attendance Team");

            // Send the email
            Transport.send(msg);

            // Show success message
            out.println("<script> alert('Registration Successful! ID and password have been sent to the email.'); location.href='teacher_Registration.html';</script>");

        } catch (Exception e) {
            out.println("<h1>Register Exception: " + e.getMessage() + "</h1>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (c1 != null) c1.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
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
        return "Handles teacher registration and email notification";
    }
}
