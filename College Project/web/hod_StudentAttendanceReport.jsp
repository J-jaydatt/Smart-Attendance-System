<%@ page import="java.sql.PreparedStatement,java.sql.Connection,java.sql.ResultSet, java.util.*, db.database_Connection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Table</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            background: whitesmoke;
            margin: 0;
            padding: 20px;
            color: black;
        }
        table {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            border: 2px solid whitesmoke;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }
        td {
            color: black;
        }
        th {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
        }
        .present {
            background-color: #4CAF50;
            color: white;
        }
        .absent {
            background-color: #FF3B30;
            color: white;
        }
        .leave {
            background-color: #FFD700;
            color: black;
        }
        .holiday {
            background-color: #FF8C00;
            color: white;
        }
        #month, #weeks {
            height: 30px;
            border-radius: 10px;
            width: 30%;
            border: none;
            padding: 5px;
        }
        .header {
            display: flex;
            width: 170%;
        }
        .header label {
            width: 30%;
            font-size: 16px;
            font-weight: bold;
            color: #6a11cb;
        }
        .header select {
            width: 60%;
            height: 35px;
            background: linear-gradient(to right, #d500f9, #7b1fa2);
            color: whitesmoke;
            border: none;
            border-radius: 8px;
            padding: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        .hea1 {
            margin-left: 5%;
            width: 50%;
        }
        .hea2 {
            width: 50%;
        }
        .hea2 label {
            margin-left: 1%;
        }
        #backk {
            margin-left: 0%;
            display: inline;
            width: 50%;
        }
        #linkbck {
            margin-left: -115%;
            text-decoration: none;
            font-size: 18px;
            background: purple;
            padding: 10px;
            color: whitesmoke;
            border-radius: 10px;
        }
        .excle {
            display: flex;
            flex-direction: column;
            border: 1px solid green;
            width: 30%;
            text-align: center;
            height: 20vh;
            background-color: #f4f3ef;
            border-radius: 10px;
        }
        select {
            margin: 20px;
            padding: 5px;
            margin-top: 5px;
        }
        .excle label {
            font-size: 25px;
        }
        .excle button {
            background-color: #28a745; /* Green color */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s ease-in-out;
        }
        .excle button:hover {
            background-color: #218838; /* Darker green */
        }
        #back {
            width: 20%;
            height: 35px;
            background: linear-gradient(to right, #d500f9, #7b1fa2);
            color: whitesmoke;
            border: none;
            border-radius: 8px;
            padding: 5px;
            font-size: 14px;
            cursor: pointer;
            margin-left: -90%;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("month").addEventListener("change", function () {
                this.form.submit();
            });
            document.getElementById("weeks").addEventListener("change", function () {
                this.form.submit();
            });
        });
    </script>
</head>
<body>

<%
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        out.println("<p>Error: Student ID is missing.</p>");
        return;
    }
    int studentId = Integer.parseInt(idParam);
    
    String className = request.getParameter("clsName");
    String teacherName = request.getParameter("teaName");

    Calendar calendar = Calendar.getInstance();
    int selectedMonth = (request.getParameter("month") != null) ? Integer.parseInt(request.getParameter("month")) : calendar.get(Calendar.MONTH);
    int selectedWeeks = (request.getParameter("weeks") != null) ? Integer.parseInt(request.getParameter("weeks")) : 1;

    calendar.set(Calendar.MONTH, selectedMonth);
    int maxDaysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
    int endDate = (selectedWeeks * 7);
    if (selectedWeeks == 5) {
        endDate = maxDaysInMonth;
    } else {
        endDate = Math.min(endDate, maxDaysInMonth);
    }
%>

<div>
    <button onclick="indexpage()" id="back">Back</button>
    <form method="get" action="hod_StudentAttendanceReport.jsp">
        <input type="hidden" name="id" value="<%= studentId %>">
        <input type="hidden" name="clsName" value="<%= className %>"> <!-- Hidden input for className -->
        <input type="hidden" name="teaName" value="<%= teacherName %>"> <!-- Hidden input for teacherName -->

        <div class="header">
            <div class="hea1">
                <label for="month">Select Month:</label>
                <select id="month" name="month">
                    <%
                        for (int i = 0; i < 12; i++) {
                            calendar.set(Calendar.MONTH, i);
                            String monthName = calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.ENGLISH);
                    %>
                    <option value="<%= i %>" <%= (selectedMonth == i) ? "selected" : "" %>><%= monthName %></option>
                    <% } %>
                </select>
            </div>

            <div class="hea2">
                <label for="weeks">Select Weeks:</label>
                <select id="weeks" name="weeks">
                    <% for (int i = 1; i <= 5; i++) { %>
                    <option value="<%= i %>" <%= (selectedWeeks == i) ? "selected" : "" %>>
                        <%= (i == 5) ? "Full Month" : "Week " + i %>
                    </option>
                    <% } %>
                </select>
            </div>
        </div>
    </form>
</div>

<table>
    <thead>
        <tr>
            <th>Date</th>
            <th>Day</th>
            <th>Subject</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <%
            Connection connection = database_Connection.getConnection();
            String sql = "SELECT a.date, DAYNAME(a.date) AS day, s.subName, a.status "
                    + "FROM attendance a "
                    + "LEFT JOIN subjects s ON a.subject_id = s.subId "
                    + "WHERE a.student_id = ? AND MONTH(a.date) = ? AND DAY(a.date) BETWEEN 1 AND ? "
                    + "ORDER BY a.date";
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            pstmt.setInt(2, selectedMonth + 1);
            pstmt.setInt(3, endDate);
            ResultSet rs = pstmt.executeQuery();

            Map<String, String[]> attendanceMap = new HashMap<>();
            while (rs.next()) {
                attendanceMap.put(rs.getString("date"), new String[]{rs.getString("status"), rs.getString("subName")});
            }

            calendar.set(Calendar.MONTH, selectedMonth);
            for (int day = 1; day <= endDate; day++) {
                calendar.set(Calendar.DAY_OF_MONTH, day);
                String formattedDate = String.format("%1$tY-%1$tm-%1$td", calendar);
                String dayName = calendar.getDisplayName(Calendar.DAY_OF_WEEK, Calendar.LONG, Locale.ENGLISH);

                String[] attendanceInfo = attendanceMap.getOrDefault(formattedDate, new String[]{"Absent", "N/A"});
                String status = attendanceInfo[0];
                String subject = attendanceInfo[1];

                String cssClass = status.equalsIgnoreCase("present") ? "present"
                        : status.equalsIgnoreCase("leave") ? "leave"
                        : status.equalsIgnoreCase("holiday") ? "holiday" : "absent";
        %>
        <tr>
            <td><%= formattedDate %></td>
            <td><%= dayName %></td>
            <td><%= subject %></td>
            <td class="<%= cssClass %>"><%= status %></td>
        </tr>
        <% } %> 
    </tbody>
</table>

<div class="excle">
    <form method="get" action="exportAttendance.jsp">
        <input type="hidden" name="id" value="<%= studentId %>">
        <label for="reportType">Download Report</label><br>
        <select id="reportType" name="reportType">
            <option value="1">One Month</option>
            <option value="2">Full Record</option>
        </select><br>
        <button type="submit">Export to Excel</button>
    </form>
</div>

</body>

<script>
    function indexpage() {
        // Retrieve values from hidden fields or directly from JSP
        var className = "<%= className %>";
        var teacherName = "<%= teacherName %>";

        // Redirect with encoded parameters
        window.location.href = "hod_ClassRecords.jsp?className=" + encodeURIComponent(className) + "&teacherName=" + encodeURIComponent(teacherName);
    }
</script>
</html>