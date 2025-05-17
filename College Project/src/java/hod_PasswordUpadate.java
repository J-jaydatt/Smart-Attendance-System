
import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/hod_PasswordUpadate")
public class hod_PasswordUpadate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String old_Pass = request.getParameter("oldPassword");
        String new_Pass = request.getParameter("newPassword");
        String confirm_Pass = request.getParameter("confirmPassword");
        
        // Check for the "passid" parameter
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("passid"));
        } catch (NumberFormatException e) {
            // Handle invalid ID format, maybe redirect with an error message
            response.sendRedirect("errorPage.jsp?error=Invalid ID");
            return;
        }
        
        Connection connection = null;
        try {
            connection = database_Connection.getConnection();
            ResultSet rs = null;
            String query = "SELECT * FROM teacher WHERE tId = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String real_Password = rs.getString("tpassword");
                
                // Check if the old password is correct
                if (!real_Password.equals(old_Pass)) {
                    // Password doesn't match
                    response.sendRedirect("hod_EditProfile.jsp?fail=Failed to update Password");
                    return;
                }
                
                // Check if the new password matches the confirm password
                if (!new_Pass.equals(confirm_Pass)) {
                    // Passwords do not match
                    response.sendRedirect("hod_EditProfile.jsp?match=Password Doesn't Match");
                    return;
                }

                // Update the password if all checks pass
                String updateQuery = "UPDATE teacher SET tpassword = ? WHERE tId = ?";
                PreparedStatement updateStmt = connection.prepareStatement(updateQuery);
                updateStmt.setString(1, new_Pass); // Set the new password
                updateStmt.setInt(2, id); // Set the ID for the teacher
                int rowsAffected = updateStmt.executeUpdate();

                // If the update was successful, redirect with success
                if (rowsAffected > 0) {
                    response.sendRedirect("hod_EditProfile.jsp?success=Password Changed Successfully");
                } else {
                    response.sendRedirect("hod_EditProfile.jsp?fail=Failed to update Password");
                }
            } else {
                // If no teacher found with the given ID
                response.sendRedirect("hod_EditProfile.jsp?fail=Teacher not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?error=Database Error");
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
