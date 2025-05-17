<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.Time, java.sql.PreparedStatement, java.util.ArrayList, java.util.List, java.sql.SQLException, db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Class Time Table HOD</title>
    <style>
        .mainbody {
            background-color: #f4f3ef;
            height: 100vh;
            width: 95%;
            padding: 30px;
            padding-top: 5px;
        }
        h2 {
            color: #0d6efd;
        }
        .tblmain {
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            height: 80vh;
            overflow: hidden;
            width: 96%;
        }
        table {
            width: 98%;
            text-align: center;
            border-collapse: collapse;
            border-radius: 10px;
            table-layout: fixed;
        }
        table th {
            background-color: #007848;
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 15px;
        }
        table td {
            padding: 20px;
            font-size: 14px;
            border-bottom: 1px solid #ddd;
        }
        table tr:nth-child(odd) {
            background-color: #f4f3ef;
        }
        table tr:nth-child(even) {
            background-color: #ffffff;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            font-size: 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
        
        #back
            {
                background-color: #6bbbed;
                color: white;
                height:30px;
                width: 10%;
                border: none;
                border-radius: 10px;
                transition: 0.4s;
                font-weight: bold;
                margin-top: 20px;
            }
            
            .adding{
                display: flex;
                align-content: center;
                justify-items: center;
                margin-bottom: 10px;
                margin-top: 5px;
            }
            #addimg
            {
                height: 1.5cm;
                width: 1.5cm;
                margin-right:-1400%;
            }
            .adding h2{
                margin-left: 35%;
                font-size: 30px;
                margin-bottom: 10px;
            }
            #add
            {
                background: none;
                border: none;
                margin-top: 10%;
                margin-right: 60%;
                margin-left: 80%;
            }
    </style>
</head>
<body>

<%
    Connection connection = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null, rs2 = null;
    List<Time[]> timeSlots = new ArrayList<>();
    int addId=1;

    try {
        connection = database_Connection.getConnection();
        int classId = Integer.parseInt(request.getParameter("className"));
        String className= request.getParameter("realClassName");

        // Query to get distinct time slots
        String sqlTimeSlots = "SELECT DISTINCT startTime, endTime FROM timetable WHERE clsId = ? ORDER BY startTime";
        pstmt = connection.prepareStatement(sqlTimeSlots);
        pstmt.setInt(1, classId);
        rs = pstmt.executeQuery();

        // Store existing time slots
        while (rs.next()) {
            timeSlots.add(new Time[]{rs.getTime("startTime"), rs.getTime("endTime")});
        }

        // If no time slots exist, provide default 1-hour slots from 9 AM to 4 PM
        if (timeSlots.isEmpty()) {
            for (int hour = 9; hour < 16; hour++) {
                timeSlots.add(new Time[]{Time.valueOf(hour + ":00:00"), Time.valueOf((hour + 1) + ":00:00")});
            }
        }
%>
<script>
     function indexpage()
    {
        window.location.href="hod_TimeTable.jsp";
    }
    </script>


<div class="mainbody">
    
    
     
            <div class="adding">
                <button onclick="indexpage()" id="back">Back</button></a>
                <h2>Class Timetable</h2>
                <form action="hod_AddTimeTable.jsp" method="POST">
                    
                    <button id="add" type="submit"> <img id="addimg" src="images/newTimeTable.png" alt=""></button>
                    <input type="hidden" name="addId" value="<%= addId %>">
                    <input type="hidden" name="className" value="<%= className%>"> 
                    
                </form>
            </div>

    
    <div class="tblmain">
        <table border="1">
            <thead>
                <tr>
                    <th>Day/Time</th>
                    <% for (Time[] slot : timeSlots) { %>
                        <th><%= slot[0] %> - <%= slot[1] %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <%
                    // Define all days of the week
                    String[] allDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

                    for (String day : allDays) { 
                        out.print("<tr><td>" + day + "</td>");

                        for (Time[] slot : timeSlots) {
                            String sqlSubject = "SELECT tt.ttId, s.subName, t.tName FROM timetable tt " +
                                                "JOIN subjects s ON tt.subId = s.subId " +
                                                "JOIN teacher t ON tt.tId = t.tId " +
                                                "WHERE tt.clsId = ? AND tt.day = ? AND tt.startTime = ? AND tt.endTime = ?";
                            PreparedStatement pstmt2 = connection.prepareStatement(sqlSubject);
                            pstmt2.setInt(1, classId);
                            pstmt2.setString(2, day);
                            pstmt2.setTime(3, slot[0]);
                            pstmt2.setTime(4, slot[1]);
                            ResultSet rs3 = pstmt2.executeQuery();

                            String subjectName = "N/A";
                            String teacherName = "N/A";
                            int recordId = -1;
                            if (rs3.next()) {
                                recordId = rs3.getInt("ttId"); // Use the correct primary key
                                subjectName = rs3.getString("subName");
                                teacherName = rs3.getString("tName");
                            }
                %>
                <td>
                    <%= subjectName %><br>
                    <small>(<%= teacherName %>)</small><br>
                    <% if (recordId != -1) { %>
                        <form action="DeleteRecordServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="recordId" value="<%= recordId %>">
                            <input type="hidden" name="className" value="<%= classId %>">
                            <button type="submit" class="delete-btn">Delete</button>
                        </form>
                    <% } %>
                </td>
                <%
                        }
                        out.print("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (rs2 != null) rs2.close();
        if (pstmt != null) pstmt.close();
        if (connection != null) connection.close();
    }
%>

</body>
</html>
