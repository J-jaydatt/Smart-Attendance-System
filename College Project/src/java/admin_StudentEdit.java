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

@WebServlet("/admin_UpdateStudent")
public class admin_StudentEdit extends HttpServlet {
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

            if (btn == 0) { // Update Student
                int id = Integer.parseInt(request.getParameter("sId"));
                String name = request.getParameter("sName");
                String className = request.getParameter("sClass");
                String email = request.getParameter("sEmail");
                String mob = request.getParameter("sContact");
                String address = request.getParameter("sAddress");

                String query = "UPDATE student SET sName=?, sEmail=?, sContact=?, sClass=?, tAddress=? WHERE sId=?";
                stmt = connection.prepareStatement(query);
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, mob);
                stmt.setString(4, className);
                stmt.setString(5, address);
                stmt.setInt(6, id);
            } 
            else if (btn == 1) { // Delete Student
                int id = Integer.parseInt(request.getParameter("sId"));
                String query = "DELETE FROM student WHERE sId=?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, id);
            }

            int row = stmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("admin_StudentList.jsp?success=Record updated");
            } else {
                response.sendRedirect("admin_StudentList.jsp?error=Record not updated");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_StudentList.jsp?error=SQL Error: " + e.getMessage());

        } 
    }
}
