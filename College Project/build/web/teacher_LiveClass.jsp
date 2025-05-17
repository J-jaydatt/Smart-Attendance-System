<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection,java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Teacher My Class</title>
    <style>
        body {
            height: 100vh;
            width: 100%;
            overflow: hidden;
            font-family: 'Roboto', Arial, sans-serif;
            padding: 0px;
        }

        .mainbody {
            background-color: #ececea;
            height: 100vh;
            width: 97%;
            padding: 10px;
            border-radius: 10px;
        }

        #back {
            margin: 10px;
            height: 40px;
            width: 10%;
            background: orange;
            border: none;
            border-radius: 10px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.3s;
        }

        #back:hover {
            background: blanchedalmond;
            color: black;
        }

        h2 {
            color: #0d6efd;
            text-align: center;
        }

        .tblmain {
            padding: 30px;
            background: #f0f5ff;
            border-radius: 12px;
            width: 92%;
            margin-left: 1.5%;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
        }

        table {
            background: #ffffff;
            color: #333;
            width: 100%;
            text-align: center;
            border-collapse: collapse;
            border-radius: 12px;
            margin-top: 5%;
            border: 1px solid #d1d1d1;
        }

        table th {
            color: white;
            height: 50px;
            background: #374785;
            font-size: 18px;
            font-weight: bold;
            text-transform: uppercase;
            padding: 12px;
        }

        table tr:nth-child(odd) {
            background-color: #f8f9fc;
        }

        table tr:nth-child(even) {
            background-color: #e9efff;
        }

        table td {
            padding: 15px;
            font-size: 16px;
            font-weight: 500;
            border: 1px solid #ddd;
        }

        table button {
            font-size: 15px;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        table .requested {
            background-color: orange;
            color: white;
        }

        table .marked {
            background-color: green;
            color: white;
        }

        table span {
            font-style: italic;
            font-size: 12px;
        }

        #logoutMessage {
            display: none;
            color: red;
            font-size: 18px;
            margin: 20px;
        }
        #endClass{
            background:#ce1021;
            border:none;
            height: 30px;
            width: 10%;
            margin-top: 20px;
            color:whitesmoke;
            border-radius: 10px;
            margin-left: 78%;   
        }
        #endClass:hover
        {
            background: #e52b4f;
        }
    </style>
</head>



<script>
    function logout() {
        return confirm("Are you sure you want to Logout?");
    }
    
   
</script>
<body>
<%
    response.setHeader("Cache-control", "no-cache,no-store,must-revalidated");

    if (session.getAttribute("id") == null) {
        response.sendRedirect("YouAreLogOut.jsp?logoutId=teacher");
    } else {
        Connection connection = null;
        PreparedStatement psmt = null;
        ResultSet rs3 = null, rs4 = null;
        String className = "";
        int tId = Integer.parseInt((String) session.getAttribute("id"));

       

        connection = database_Connection.getConnection();

        int classId = Integer.parseInt(request.getParameter("classId"));
        String subjectId = request.getParameter("subjectId");
        int curTeacherId = Integer.parseInt(request.getParameter("teacherId"));
        String day = request.getParameter("day");
        String startTime=request.getParameter("st");
        String endTime=request.getParameter("et");
        
        
        
        // Get class name
        String sql3 = "SELECT className FROM classes WHERE classId=?";
        psmt = connection.prepareStatement(sql3);
        psmt.setInt(1, classId);
        rs3 = psmt.executeQuery();
        if (rs3.next()) {
            className = rs3.getString("className");
        }
%>

<div class="mainbody">
    <button id="back" onclick="history.back()">Back</button>

    <h2 id="tdyses">Live</h2>
    

    <div class="tblmain" id="tableId">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Status</th>
            </tr>
            <%
                String sql4 = "SELECT * FROM student WHERE sClass=?";
                psmt = connection.prepareStatement(sql4);
                psmt.setString(1, className);
                rs4 = psmt.executeQuery();
                while (rs4.next()) {
                    int status = rs4.getInt("requested");
            %>
            <tr>
                <td><%= rs4.getInt("sId") %></td>
                <td><%= rs4.getString("sName") %></td>

                <td id="colbtn">
                    <% if (status == 1) { %>
                        <form action="markStudentAtt" method="post">
                            <input type="hidden" name="sId" value="<%= rs4.getInt("sId") %>">
                            <input type="hidden" name="classId" value="<%= classId %>">
                            <input type="hidden" name="subId" value="<%= subjectId %>">
                            <input type="hidden" name="teaId" value="<%= curTeacherId %>">
                            <input type="hidden" name="updateValue" value="0">
                            <button class="requested" type="submit">Accept<br><span>(Requested)</span></button>
                        </form>
                    <% } else if (status == 3) { %>
                        <button class="marked" disabled>Marked</button>
                    <% } else { %>
                        <span style="color:red;">Not Requested</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
        <form action="markStudentAtt" method="post" id="endClassForm">
            <input type="hidden" name="updateValue" value="1">
            <input type="hidden" name="classname" value="<%= className %>">
            <input type="hidden" name="classId" value="<%= classId %>">
        <button id="endClass" type="submit" onclick="endingClass(event)">End Class</button>
</form>


    </div>
</div>
        
        
      <script>
    function endingClass(event) {
        event.preventDefault(); // Prevent form submission

        let endTime = "<%= endTime %>"; // Get end time from JSP
        let endDate = new Date();
        let timeParts = endTime.split(":"); // Assuming format is "HH:mm:ss"
        endDate.setHours(timeParts[0], timeParts[1], timeParts[2], 0);

        let currentTime = new Date(); // Get current time
        let diff = endDate - currentTime; // Difference in milliseconds

        let message;
        if (diff > 0) {
            let minutes = Math.floor(diff / 60000); // Convert to minutes
            let seconds = Math.floor((diff % 60000) / 1000); // Get remaining seconds
            message = `Time remaining: ${minutes} minutes ${seconds} seconds.\nAre you sure you want to end the class?`;
        } else {
            message = "The class time is over.\nAre you sure you want to end the class?";
        }

        if (confirm(message)) {
            document.getElementById("endClassForm").submit(); // Submit the form
        }
    }
</script>


<%
        psmt.close();
        connection.close();
    }
%>
</body>
</html>
