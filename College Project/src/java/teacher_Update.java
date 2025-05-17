import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/teacher_Update")
@MultipartConfig(maxFileSize = 160000000) 
public class teacher_Update extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mob = request.getParameter("mob");
        String password = request.getParameter("password");

        Part filePart = request.getPart("photo");
        InputStream ins = null;

        if (filePart != null && filePart.getSize() > 0) {
            ins = filePart.getInputStream(); // New file uploaded
        }

        Connection connection = null;

        try {
            connection = database_Connection.getConnection();

            // If no new file is uploaded, keep the existing image
            if (ins == null) {
                String getImageQuery = "SELECT img FROM teacher WHERE tId=?";
                PreparedStatement ps = connection.prepareStatement(getImageQuery);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    ins = rs.getBinaryStream("img"); // Keep the existing image
                }
            }

            // Update query
            String query = "UPDATE teacher SET tName=?, tEmail=?, tContact=?, tPassword=?, img=? WHERE tId=?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, mob);
            stmt.setString(4, password);
            stmt.setBinaryStream(5, ins); // Keep the previous image if no new image is uploaded
            stmt.setInt(6, id);

            int row = stmt.executeUpdate();
            if (row > 0) {
                response.sendRedirect("teacher_EditProfile.jsp?message=Profile updated successfully");
            } else {
                response.getWriter().println("<script>alert('Records not updated!'); location.href='teacher_EditProfile.jsp';</script>");
            }
        } catch (IOException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
        }
    }
}
