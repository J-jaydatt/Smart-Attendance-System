<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.sql.PreparedStatement, db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Class Time Table</title>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this record?");
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .table-container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007848;
            color: white;
        }
        button {
            background: #d9534f;
            color: white;
            border: none;
            padding: 7px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #c9302c;
        }
    </style>
</head>
<body>
<%
    Connection connection = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        int classId = Integer.parseInt(request.getParameter("className"));
        connection = database_Connection.getConnection();

        String sql = "SELECT t.tid, t.tname, s.subName, tt.time_slot FROM timetable tt " +
                     "JOIN teacher t ON tt.teacher_id = t.tid " +
                     "JOIN subjects s ON tt.subject_id = s.subId " +
                     "WHERE tt.class_id = ?";
        pst = connection.prepareStatement(sql);
        pst.setInt(1, classId);
        rs = pst.executeQuery();
%>
<div class="table-container">
    <h2>Class Time Table</h2>
    <table>
        <thead>
            <tr>
                <th>Teacher Name</th>
                <th>Subject</th>
                <th>Time</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("tname") %></td>
                <td><%= rs.getString("subName") %></td>
                <td><%= rs.getString("time_slot") %></td>
                <td>
                    <form action="deleteTimetable.jsp" method="POST" onsubmit="return confirmDelete();">
                        <input type="hidden" name="teacherId" value="<%= rs.getInt("tid") %>">
                        <input type="hidden" name="classId" value="<%= classId %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
        <%
            } 
        %>
        </tbody>
    </table>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>