import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/admin_TeacherStudent")
public class admin_TeacherEdit extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            // Get Button Action
            String btnValue = request.getParameter("btn");
            int btn = (btnValue != null) ? Integer.parseInt(btnValue) : -1;

            // Get Database Connection
            connection = database_Connection.getConnection();

            if (btn == 0) {
                // Update Student
                int id = Integer.parseInt(request.getParameter("sId"));
                String name = request.getParameter("sName");
                String email = request.getParameter("sEmail");
                String mob = request.getParameter("sContact");

                String query = "UPDATE teacher SET tName=?, tEmail=?, tContact=? WHERE tId=?";
                stmt = connection.prepareStatement(query);
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, mob);
                stmt.setInt(4, id);
            } 
            else if (btn == 1) { // Delete Student
                int id = Integer.parseInt(request.getParameter("sId"));
                String query = "DELETE FROM teacher WHERE tId=?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, id);
            }

            int row = stmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("admin_TeacherList.jsp?success=Record updated");
            } else {
                response.sendRedirect("admin_TeacherList.jsp?error=Record not updated");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("admin_TeacherList.jsp?error=Invalid input");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_TeacherList.jsp?error=Database error");
        } finally {
            // Close Resources
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
