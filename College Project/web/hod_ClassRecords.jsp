<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.sql.PreparedStatement, db.database_Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Class Tab Hod</title>
    <script>
        function logout() {
            return confirm("Are you sure you want to Logout?");
        }

        function searchStudent() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("studentTableBody");
            let rows = table.getElementsByTagName("tr");

            for (let i = 0; i < rows.length; i++) {
                let nameCell = rows[i].getElementsByTagName("td")[0]; // First column (Student Name)
                if (nameCell) {
                    let name = nameCell.textContent.toLowerCase();
                    if (name.includes(input)) {
                        rows[i].style.display = ""; // Show row if match found
                    } else {
                        rows[i].style.display = "none"; // Hide row if no match
                    }
                }
            }
        }
    </script>
    <style>
        body {
            width: 100%;
            font-family: 'Roboto', Arial, sans-serif;
        }
        .mainbody {
            background-color: #f4f3ef;
            width: 100%;
            padding: 20px;
        }
        h2 {
            color: #0d6efd;
        }
        .tblmain {
            padding: 20px;
            background: white;
            border-radius: 10px;
            width: 95%;
        }
        table {
            width: 100%;
            text-align: center;
            border-collapse: collapse;
            border-radius: 10px;
        }
        table th {
            height: 40px;
            background: #00B4CC;
            color: white;
        }
        table tr:nth-child(odd) {
            background-color: #f4f3ef;
        }
        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table td {
            padding: 10px;
            height: 35px;
        }
        table button {
            background-color: orange;
            color: white;
            border: none;
            height: 30px;
            border-radius: 10px;
            width: 40%;
        }
             .heading
            {              
                width: 95%;
                display: flex;
                padding: 3px;
            }
            .classData{
                width: 50%;
            }
            .classData h4{
                margin: 2px;
                width: 100%;  
            }
        .search {
            width: 80%;
            position: relative;
            display: flex;
            margin-top: 0%;
            margin-left: 60%;
        }
        .searchTerm {
            width: 60%;
            border: 3px solid #00B4CC;
            border-right: none;
            padding: 5px;
            height: 20px;
            border-radius: 5px 0 0 5px;
            outline: none;
            color: #9DBFAF;
        }
        .searchTerm:focus {
            color: #00B4CC;
        }
        .searchButton {
            width: 50px;
            height: 36px;
            border: 1px solid #00B4CC;
            background: #00B4CC;
            text-align: center;
            color: #fff;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-size: 20px;
        }
        #back {
            width: 20%;
            height: 35px;
            background: #00B4CC;
            color: whitesmoke;
            border: none;
            border-radius: 8px;
            padding: 5px;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
    
    <script>
    function indexpage() {
        window.location.href = "hod_Classes.jsp";
    }
</script>
    
</head>
<body>
    <%
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        connection = database_Connection.getConnection();
        String className = request.getParameter("className");
        String teacherName = request.getParameter("teacherName");
        
    %>

    <div class="mainbody">
        
        
        <div class="heading">
            
            <div class="classData">
                <h4>Class Teacher:<%= teacherName %></h4>
                <h4>Class:<%= className %></h4>
            </div>
            
            <div class="search">
                <input type="text" id="searchInput" class="searchTerm" placeholder="Search Student by Name" onkeyup="searchStudent()">
                <button type="submit" class="searchButton">
                    <i class="fa fa-search"></i>
                </button>
            </div>
            <button onclick="indexpage()" id="back">Back</button>
        </div>

        <div class="tblmain">
            <table>
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                    <%
                        String sql = "SELECT * FROM student WHERE sClass = ?";
                        pstmt = connection.prepareStatement(sql);
                        pstmt.setString(1, className);
                        rs = pstmt.executeQuery();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("sName")%></td>
                        <td><%= rs.getString("sEmail")%></td>
                        <td><%= rs.getString("sContact")%></td>
                <form action="hod_StudentAttendanceReport.jsp" method="Post">
                        <td><button>Report</button></td>
                        <input type="hidden"  value="<%= rs.getInt("sId") %>" name="id">
                        <input type="hidden"  value="<%= className %>" name="clsName">
                        <input type="hidden"  value="<%= teacherName %>" name="teaName">
                        
                </form>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
