
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteRecordServlet")
public class deleteTimeTableRecord extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int recordId = Integer.parseInt(request.getParameter("recordId"));
            int classId = Integer.parseInt(request.getParameter("className"));

            Connection connection = database_Connection.getConnection();
            String sqlDelete = "DELETE FROM timetable WHERE ttId = ?";
            PreparedStatement pstmt = connection.prepareStatement(sqlDelete);
            pstmt.setInt(1, recordId);

            int rowsAffected = pstmt.executeUpdate();
            pstmt.close();
            connection.close();

            if (rowsAffected > 0) {
                response.sendRedirect("hod_ClassTimeTable.jsp?className=" + classId);
            } else {
                response.getWriter().println("<script>alert('Error deleting record!'); history.back();</script>");
            }
        } catch (Exception e) {
            response.getWriter().println("<script>alert('Invalid Operation!'); history.back();</script>");
        }
    }
}
