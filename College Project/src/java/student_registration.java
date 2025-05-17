
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


@WebServlet(urlPatterns = {"/student_Register"})
public class student_registration extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        Connection c1 = null;
        PreparedStatement pst = null, checkStrengthStmt = null, studentCountStmt = null;
        ResultSet rs = null, classRs = null, studentRs = null;
        int sRollNo = 0;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            c1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/myProject", "root", "root1234");

            // Get parameters from the form
            String sName = request.getParameter("student_Name");
            String sClass = request.getParameter("student_Class");
            String sGender = request.getParameter("student_Gender");
            String sContact = request.getParameter("student_Contact");
            String sAddress = request.getParameter("student_Address");
            final String sEmail = request.getParameter("student_Email");

            // Get the class strength from `classes` table
            String checkStrengthQuery = "SELECT strength FROM classes WHERE className = ?";
            checkStrengthStmt = c1.prepareStatement(checkStrengthQuery);
            checkStrengthStmt.setString(1, sClass);
            classRs = checkStrengthStmt.executeQuery();

            int classStrength = 0;
            if (classRs.next()) {
                classStrength = classRs.getInt("strength");
            }

            // Get the current student count in this class
            String studentCountQuery = "SELECT COUNT(*) FROM student WHERE sClass = ?";
            studentCountStmt = c1.prepareStatement(studentCountQuery);
            studentCountStmt.setString(1, sClass);
            studentRs = studentCountStmt.executeQuery();

            int currentStudentCount = 0;
            if (studentRs.next()) {
                currentStudentCount = studentRs.getInt(1);
            }

            // Check if the class is full
            if (currentStudentCount >= classStrength) {
                out.println("<script>");
                out.println("alert('Registration Failed: The class " + sClass + " has reached its maximum strength.');");
                out.println("location.href='admin_StudentOperations.jsp';");
                out.println("</script>");
            } else {
                // Find the max sId from the student table
                String q1 = "SELECT MAX(sId) FROM student";
                pst = c1.prepareStatement(q1);
                rs = pst.executeQuery();
                if (rs.next()) {
                    sRollNo = rs.getInt(1) + 99;
                }

                // Generate a temporary password
                String tempPassword = "Temp@" + (int) (Math.random() * 10000);

                // Insert student data into the database
                String sql = "INSERT INTO student (sId, sName, sClass, sGender, sContact, sEmail, Password, tAddress) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pst = c1.prepareStatement(sql);
                pst.setInt(1, sRollNo);
                pst.setString(2, sName);
                pst.setString(3, sClass);
                pst.setString(4, sGender);
                pst.setString(5, sContact);
                pst.setString(6, sEmail);
                pst.setString(7, tempPassword);
                pst.setString(8, sAddress);
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
                            "Student ID: " + sRollNo + "\n" +
                            "Temporary Password: " + tempPassword + "\n\n" +
                            "Please log in and change your password immediately.\n\n" +
                            "Best regards,\nSmart Attendance Team");

                // Send the email
                Transport.send(msg);

                // Redirect to success page
                int refreshId = Integer.parseInt(request.getParameter("rId"));
                if (refreshId == 1) {
                    out.println("<script>");
                    out.println("alert('Registration Successful! ID and password have been sent to the email.');");
                    out.println("location.href='admin_StudentOperations.jsp';");
                    out.println("</script>");
                }  
               
                else
                {
                     out.println("<p>No valid refreshId received.</p>"+refreshId);
                }
            }

        } catch (Exception e) {
            out.println("<h1>Register Exception: " + e.getMessage() + "</h1>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (classRs != null) classRs.close(); } catch (Exception e) {}
            try { if (studentRs != null) studentRs.close(); } catch (Exception e) {}
            try { if (checkStrengthStmt != null) checkStrengthStmt.close(); } catch (Exception e) {}
            try { if (studentCountStmt != null) studentCountStmt.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (c1 != null) c1.close(); } catch (Exception e) {}
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
        return "Handles student registration and email notification";
    }
}
