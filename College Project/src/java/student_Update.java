import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/student_Update")
@MultipartConfig(maxFileSize = 1600000000) 
public class student_Update extends HttpServlet {
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

        try (Connection connection = database_Connection.getConnection()) {
            if (ins == null) {
                String getImageQuery = "SELECT img FROM student WHERE sId=?";
                try (PreparedStatement ps = connection.prepareStatement(getImageQuery)) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            ins = rs.getBinaryStream("img"); // Keep the existing image
                        }
                    }
                }
            }

            String query = "UPDATE student SET sName=?, sEmail=?, sContact=?, Password=?, img=? WHERE sId=?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, mob);
                stmt.setString(4, password);
                stmt.setBinaryStream(5, ins);
                stmt.setInt(6, id);

                int row = stmt.executeUpdate();
                if (row > 0) {
                    response.sendRedirect("student_EditProfile.jsp?message=Profile updated successfully");
                } else {
                    response.getWriter().write("Error: Records not updated!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating profile: " + e.getMessage());
        }
    }
}
