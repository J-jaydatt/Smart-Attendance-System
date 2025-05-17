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

@WebServlet("/LoginServlet")
public class hod_Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String hod_Id = request.getParameter("hod_Id");
        String hod_password = request.getParameter("hod_Password");

        boolean isValidUser = false;
        Connection connection = null;

        try {
            // Establish connection to the database
            connection = database_Connection.getConnection();
            String query = "SELECT * FROM teacher WHERE tid = ? AND tpassword = ?";
            
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, hod_Id);
                stmt.setString(2, hod_password);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        isValidUser = true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("hod_Login.jsp?error=database");
            return;
        } finally {
            database_Connection.closeConnection(connection);
        }

        if (isValidUser) {
            // Create session for the user
            HttpSession session = request.getSession(true);
            session.setAttribute("id", hod_Id);
            response.sendRedirect("hod_Index.jsp");
        } else {
                      response.sendRedirect("hod_Login.jsp?error=invalid");
        }
    }
}
