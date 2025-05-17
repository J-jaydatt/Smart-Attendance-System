import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(urlPatterns = {"/verifyteacher"})
public class verifyTeacher extends HttpServlet {  // Extend HttpServlet

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String verificationIdStr = request.getParameter("verficationId");  // Ensure it matches JSP

        String verified = "1";
        Connection connection = null;

        try {
            connection = database_Connection.getConnection();
            String query = "UPDATE teacher SET verified=? WHERE tId=?";
            
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, verified);
            stmt.setString(2, verificationIdStr);
              
            int row = stmt.executeUpdate();
              
            if (row > 0) {
                response.sendRedirect("hod_TeacherRequests.jsp?message=Profile updated successfully");
            } else {
                response.getWriter().println("<script> alert('Records not Updated !! '); location.href='hod_TeacherRequests.jsp';</script>");  
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
