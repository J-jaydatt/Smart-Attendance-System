import db.database_Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.sql.PreparedStatement;

@WebServlet("/addNewTimeTable")
public class addNewClass extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement pstmtCheckConflict = null;
        PreparedStatement pstmtCheckTeacherConflict = null;
        PreparedStatement pstmtCheckClassTeacher = null;
        PreparedStatement pstmtInsert = null;
        ResultSet rs = null;

        try {
            // Get form data
            String teacherIdStr = request.getParameter("teacherId");
            String subIdStr = request.getParameter("subjectId");
            String classIdStr = request.getParameter("classId");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String classTeacher = request.getParameter("isClassTeacher");
            String day = request.getParameter("day");

            // Validate input values
            if (teacherIdStr == null || subIdStr == null || classIdStr == null || startTime == null || endTime == null || day == null) {
                response.sendRedirect("hod_AddTimeTable.jsp?fail=All fields are mandatory.");
                return;
            }

            int teacherId = Integer.parseInt(teacherIdStr);
            int subId = Integer.parseInt(subIdStr);
            int classId = Integer.parseInt(classIdStr);
            java.sql.Date date = new java.sql.Date(System.currentTimeMillis());

            boolean isChecked = (classTeacher != null && classTeacher.equals("on"));
            int classTeacherId = isChecked ? teacherId : 0;

            Time start = Time.valueOf(startTime + ":00");
            Time end = Time.valueOf(endTime + ":00");
            long duration = (end.getTime() - start.getTime()) / (1000 * 60);
            if (duration < 15) {
                response.sendRedirect("hod_AddTimeTable.jsp?fail=Class duration must be at least 15 minutes.");
                return;
            }

            connection = database_Connection.getConnection();

            // 1. Check if class already has a session at this time
            String checkConflictSQL = "SELECT COUNT(*) FROM timetable WHERE clsId = ? AND day = ? AND ("
                    + "(startTime < ? AND endTime > ?) OR "
                    + "(startTime < ? AND endTime > ?) OR "
                    + "(startTime >= ? AND startTime < ?) OR "
                    + "(endTime > ? AND endTime <= ?))";

            pstmtCheckConflict = connection.prepareStatement(checkConflictSQL);
            pstmtCheckConflict.setInt(1, classId);
            pstmtCheckConflict.setString(2, day);
            pstmtCheckConflict.setTime(3, start);
            pstmtCheckConflict.setTime(4, start);
            pstmtCheckConflict.setTime(5, end);
            pstmtCheckConflict.setTime(6, end);
            pstmtCheckConflict.setTime(7, start);
            pstmtCheckConflict.setTime(8, end);
            pstmtCheckConflict.setTime(9, start);
            pstmtCheckConflict.setTime(10, end);

            rs = pstmtCheckConflict.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                response.sendRedirect("hod_AddTimeTable.jsp?fail=Time conflict: This class already has a session at this time.");
                return;
            }

            // 2. Check if teacher is already teaching any other class at the same time
            String checkTeacherConflictSQL = "SELECT COUNT(*) FROM timetable WHERE tId = ? AND day = ? AND ("
                    + "(startTime < ? AND endTime > ?) OR "
                    + "(startTime < ? AND endTime > ?) OR "
                    + "(startTime >= ? AND startTime < ?) OR "
                    + "(endTime > ? AND endTime <= ?))";

            pstmtCheckTeacherConflict = connection.prepareStatement(checkTeacherConflictSQL);
            pstmtCheckTeacherConflict.setInt(1, teacherId);
            pstmtCheckTeacherConflict.setString(2, day);
            pstmtCheckTeacherConflict.setTime(3, start);
            pstmtCheckTeacherConflict.setTime(4, start);
            pstmtCheckTeacherConflict.setTime(5, end);
            pstmtCheckTeacherConflict.setTime(6, end);
            pstmtCheckTeacherConflict.setTime(7, start);
            pstmtCheckTeacherConflict.setTime(8, end);
            pstmtCheckTeacherConflict.setTime(9, start);
            pstmtCheckTeacherConflict.setTime(10, end);

            rs = pstmtCheckTeacherConflict.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                response.sendRedirect("hod_AddTimeTable.jsp?fail=This teacher is already teaching another class at this time.");
                return;
            }

            // 3. Check if a class teacher is already assigned for this class
            if (isChecked) {
                String checkClassTeacherSQL = "SELECT COUNT(*) FROM timetable WHERE clsId = ? AND classTeacherId != 0";
                pstmtCheckClassTeacher = connection.prepareStatement(checkClassTeacherSQL);
                pstmtCheckClassTeacher.setInt(1, classId);

                rs = pstmtCheckClassTeacher.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    response.sendRedirect("hod_AddTimeTable.jsp?fail=This class already has a class teacher assigned.");
                    return;
                }
            }

            // 4. Insert into timetable
            String insertSQL = "INSERT INTO timetable (clsId, subId, day, Date, startTime, endTime, tId, classTeacherId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmtInsert = connection.prepareStatement(insertSQL);
            pstmtInsert.setInt(1, classId);
            pstmtInsert.setInt(2, subId);
            pstmtInsert.setString(3, day);
            pstmtInsert.setDate(4, date);
            pstmtInsert.setTime(5, start);
            pstmtInsert.setTime(6, end);
            pstmtInsert.setInt(7, teacherId);
            pstmtInsert.setInt(8, classTeacherId);

            int rowsAffected = pstmtInsert.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("hod_AddTimeTable.jsp?success=TimeTable successfully added.");
            } else {
                response.sendRedirect("hod_AddTimeTable.jsp?fail=Failed to add timetable.");
            }

        } catch (SQLException | NumberFormatException e) {
            response.sendRedirect("hod_AddTimeTable.jsp?fail=Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmtCheckConflict != null) pstmtCheckConflict.close();
                if (pstmtCheckTeacherConflict != null) pstmtCheckTeacherConflict.close();
                if (pstmtCheckClassTeacher != null) pstmtCheckClassTeacher.close();
                if (pstmtInsert != null) pstmtInsert.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
