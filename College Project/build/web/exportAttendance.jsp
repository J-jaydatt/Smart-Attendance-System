<%@ page import="java.io.*, java.sql.*,java.sql.PreparedStatement, java.util.*, db.database_Connection" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ page language="java" %>

<%
    String idParam = request.getParameter("id");
    String reportType = request.getParameter("reportType");

    if (idParam == null || idParam.isEmpty()) {
        out.println("Error: Student ID is missing.");
        return;
    }

    int studentId = Integer.parseInt(idParam);
    int selectedMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;  // Default to current month
    String dateCondition = "MONTH(a.date) = " + selectedMonth; // Default: one-month data

    if ("2".equals(reportType)) {  
        dateCondition = "1=1";  // Fetch all records for full report
    }

    Connection connection = database_Connection.getConnection();

    // Fetch Student Name & Class
    String studentQuery = "SELECT s.sName, s.sClass FROM student s WHERE s.sId = ?";
    PreparedStatement studentStmt = connection.prepareStatement(studentQuery);
    studentStmt.setInt(1, studentId);
    ResultSet studentRs = studentStmt.executeQuery();

    String studentName = "Unknown";
    String studentClass = "Unknown";

    if (studentRs.next()) {
        studentName = studentRs.getString("sName");
        studentClass = studentRs.getString("sClass");
    }

    // Ensure the filename is safe for Excel export (remove spaces/special characters)
    String safeFileName = studentName.replaceAll("\\s+", "_") + "_Attendance_Report.xls";

    // SQL Query to fetch attendance records
    String sql = "SELECT a.date, DAYNAME(a.date) AS day, s.subName, a.status " +
                 "FROM attendance a " +
                 "LEFT JOIN subjects s ON a.subject_id = s.subId " +
                 "WHERE a.student_id = ? AND " + dateCondition +
                 " ORDER BY a.date";

    PreparedStatement pstmt = connection.prepareStatement(sql);
    pstmt.setInt(1, studentId);
    ResultSet rs = pstmt.executeQuery();

    // Setting up response headers for Excel download with student's name as file name
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment; filename=" + safeFileName);

    // Get current date for report generation
    String reportDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>

<html>
<head>
    <title>Export Attendance Report</title>
</head>
<body>

    <h2 style="color:red">Student Attendance Report</h2>
    <table border="1">
        <tr>
            <th style="font-weight: bold">Student Name</th>
            <td><%= studentName %></td>
        </tr>
        <tr>
            <th style="font-weight: bold">Class</th>
            <td><%= studentClass %></td>
        </tr>
        <tr>
            <th style="font-weight: bold">Report Generated On</th>
            <td><%= reportDate %></td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <th>Date</th>
            <th>Day</th>
            <th>Subject</th>
            <th>Status</th>
        </tr>

        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("day") %></td>
            <td><%= rs.getString("subName") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <% } %>

    </table>

</body>
</html>
