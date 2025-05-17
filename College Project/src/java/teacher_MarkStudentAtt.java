import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/markStudentAtt")
@MultipartConfig(maxFileSize = 1600000)
public class teacher_MarkStudentAtt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int whichUpdate = getIntParameter(request, "updateValue");
        LocalTime currentTime = LocalTime.now(); // Get current time
        LocalDate currentDate = LocalDate.now(); // Get current date

        try (Connection connection = database_Connection.getConnection()) {
            
            if (whichUpdate == 0) {
                // Insert new attendance record with startTime
                int sid = getIntParameter(request, "sId");
                int classId = getIntParameter(request, "classId");
                int subId = getIntParameter(request, "subId");
                int curteaId = getIntParameter(request, "teaId");

                if (sid == -1 || classId == -1 || subId == -1 || curteaId == -1) {
                    response.getWriter().println("<h1>Error: Missing required parameters!</h1>");
                    return;
                }

                String query = "INSERT INTO attendance (student_id, class_id, subject_id, teacher_id, date, status, startTime) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement stmt = connection.prepareStatement(query)) {
                    stmt.setInt(1, sid);
                    stmt.setInt(2, classId);
                    stmt.setInt(3, subId);
                    stmt.setInt(4, curteaId);
                    stmt.setDate(5, Date.valueOf(currentDate)); 
                    stmt.setString(6, "Present"); 
                    stmt.setTime(7, Time.valueOf(currentTime));

                    int row = stmt.executeUpdate();

                    if (row > 0) {
                        // Update student table (requested = 3)
                        String query2 = "UPDATE student SET requested = 3 WHERE sId = ?";
                        try (PreparedStatement stmtt = connection.prepareStatement(query2)) {
                            stmtt.setInt(1, sid);
                            stmtt.executeUpdate();
                        }

                        response.sendRedirect("teacher_LiveClass.jsp?classId=" + classId + "&subId=" + subId + "&day=" + currentDate + "&teacherId=" + curteaId);
                    }
                }

            } else if (whichUpdate == 1) {
                // Update attendance table with endTime for a specific classId
                int classId = getIntParameter(request, "classId");
                String classname=request.getParameter("classname");

                if (classId == -1) {
                    response.getWriter().println("<h1>Error: Missing classId!</h1>");
                    return;
                }

                // Update `endTime` and `requested = 0` where `requested = 3`
                try {
                    connection.setAutoCommit(false); // Start transaction

                    // Update attendance table
                    String sql1 = "UPDATE attendance SET endTime = ? WHERE class_id = ? AND date = ?";
                    try (PreparedStatement stmt1 = connection.prepareStatement(sql1)) {
                        stmt1.setTime(1, Time.valueOf(currentTime));
                        stmt1.setInt(2, classId);
                        stmt1.setDate(3, Date.valueOf(currentDate));

                        stmt1.executeUpdate();
                    }

                    // Update student table (set requested = 0 where requested = 3)
                    String sql2 = "UPDATE student SET requested = 0 WHERE sClass = ? AND requested = 3";
                    try (PreparedStatement stmt2 = connection.prepareStatement(sql2)) {
                        stmt2.setString(1, classname);
                        stmt2.executeUpdate();
                    }

                    connection.commit(); // Commit transaction
                    response.sendRedirect("teacher_Index.jsp");

                } catch (SQLException e) {
                    connection.rollback(); // Rollback on error
                    e.printStackTrace();
                    response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
                } finally {
                    connection.setAutoCommit(true); // Restore default behavior
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
        }
    }

    // Helper method to safely parse integer parameters
    private int getIntParameter(HttpServletRequest request, String paramName) {
        String paramValue = request.getParameter(paramName);
        if (paramValue == null || paramValue.trim().isEmpty()) {
            System.out.println(paramName + " is null or empty");
            return -1; 
        }
        try {
            return Integer.parseInt(paramValue);
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format for " + paramName);
            return -1; 
        }
    }
}
