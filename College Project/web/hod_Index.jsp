<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ page import="java.sql.*, db.database_Connection,java.sql.PreparedStatement" %>
<html lang="en">
    <head>
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hod Main Page</title>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <script>
            function logout()
            {
                return confirm("Are you sure You want to Logout ?");
            }
        </script>
        <style>
            body{
                height: 100vh;
                width: 100%;
                overflow: hidden;
                font-family: 'Roboto', Arial, sans-serif;
            }
            /* side navigation bar css */
            .navmain
            {
                height: 93vh;
                width: 17%;
                float: left;
                padding: 20px;
            }
            .profile
            {
                height: 15vh;
                width: 85%;
                text-align: center;
                padding: 15px;
                border-radius: 10px;
            }
            .profile button
            {
                background-color: #6bbbed;
                color: white;
                height:25px;
                width: 50%;
                border: none;
                border-radius: 20px;
                transition: 0.4s;
            }
            .profile button:hover{
                height: 28px;
                width: 55%;
            }
            #logo
            {
                height: 2cm;
                width: 2cm;
                background: white;
                padding: 5px;
                border-radius: 70px;
                border: 1px solid #6bbbed;
            }
            hr
            {
                border: none;
                height: 3px;
                background-color: silver; /* Adjust to your color */
                margin-top:50px;
            }
            .navbaroption {
                margin-top: 5%;
                height: 70vh;
                width: 85%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .navbaroption a {
                text-decoration: none;
                position: relative;
                color: #0d6efd;
                padding: 5px 0;


                text-decoration: none;
                color: black;
                font-size: 20px;
                display: flex; /* Makes the link a flex container */
                align-items: center; /* Centers the image and text vertically */
                margin-top: 25%;
                gap: 10px; /* Adds space between the image and text */
                transition: color 0.3s ease; /* Smooth transition for hover color */
            }
            .navbaroption a::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: 2px;
                background: #007BFF;
                transition: width 0.3s ease;
            }

            .navbaroption a:hover::after {
                width: 100%;
            }

            .navbaroption a:hover {
                color: #0d6efd; /* Hover color */
            }

            .navbaroption img {
                height: 0.8cm;
                width: 0.8cm;
                display: block; /* Ensures the image behaves like a block element */
            }

            #Dashboard
            {
                color: #0d6efd;
                margin-top: 20px;
                /*                text-decoration: underline #0d6efd;
                                text-underline-offset: 5px;*/
            }
            form button{
                margin-top: 35%;
                display: flex;
                background: none;
                border:none
            }
            form span{
                margin-top: 4%;
                font-size: 20px;
                margin-left: 5px;
            }
            .top
            {
                display: flex;
                align-items: center;
            }
            .top img
            {
                height: 2cm;
                width: 2cm;
                margin-left: 75%;
                transition: 0.4s;
            }
            .top img:hover{
                height: 1.2cm;
                width: 1.2cm;
            }
            #quickadd
            {
                display: inline-block;
                border: none;
                color:orange;
                height: 30px;
                background: none;
                font-size: 20px;
            }

            /* main interface ui css */

            .mainbody
            {
                background-color: #f4f3ef;
                height: 100vh;
                width: 77%;
                margin-left:20%;
                padding: 20px;
            }
            h2{
                color: #0d6efd;
            }
            .dashboard
            {
                height: 30vh;
                display: flex;
                justify-content: space-evenly;
                padding: 20px;
                background: white;
                border-radius: 10px;
            }

            /* teacher student and total containers css */
            .container_1
            {
                width: 25%;
                border: 1px solid #0d6efd;
                background-color: rgb(173, 216, 255);
                border-radius: 10px;
                text-align: center;
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
                /* background-color: rgba(13, 110, 253, 0.2); */
            }
            .container_2
            {
                text-align: center;
                border: 1px solid rgb(255, 213, 0);
                background-color: rgb(255, 250, 200);
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
                border-radius: 10px;
                width: 25%;
            }
            .container_3
            {
                width: 25%;
                text-align: center;
                border: 1px solid pink;
                background-color: rgb(216, 191, 216);
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
                border-radius: 10px;
            }

            /* TOTAL CONTAINER CSS  */
            .cont_3
            {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 10vh;
            }
            p{
                display: inline-block;
                font-size: 40px;
                margin-bottom: 60px;
            }

            /* STUDENT AND TEACHER CONTAINER CSS */
            #student , #teacher
            {
                display: block;
                margin-left: 33%;
                height: 2cm;
                width: 2cm;
                padding: 8px;
                border-radius: 25px;
                margin-bottom: 30px;
            }
            #Present ,#notPresent
            {
                height: 1cm;
                width: 1cm;
                padding: 8px;
                margin-left: 10%;
                margin-right: 10%;
                margin-bottom: 10px;
            }
            #notPresent
            {
                height: 1.01cm;
                width: 1.01cm;
            }
            #totalTeacher , #totalStudent
            {
                height: 1cm;
                width: 1cm;
                margin:10px 30px 40px 40px;
            }
            label
            {
                font-weight: bold;
                margin: 20px 38px 38px 35px;
                font-size: 25px;
            }

            /* TABLE MAIN CSS OUTLINE */
            .tblmain {
                padding: 20px;
                background: white;
                border-radius: 10px;
                height: 40vh;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .scrollable-table {
                max-height: 40vh; /* Adjust height to fit within .tblmain */
                overflow-y: auto;
                border-radius: 10px;
                border: 1px solid #ddd;
            }

            .scrollable-table table {
                width: 100%;
                border-collapse: collapse;
                height: 40vh;
            }

            .scrollable-table th {
                position: sticky;
                top: 0;
                background-color: #6bbbed; /* Updated to match your theme */
                color: white;
                padding: 12px;
                text-align: center;
                font-size: 16px;
                border-bottom: 2px solid #ddd;
                z-index: 2;
            }

            .scrollable-table td {
                padding: 12px;
                text-align: center;
                font-size: 14px;
                border-bottom: 1px solid #ddd;
            }

            .scrollable-table tr:nth-child(odd) {
                background-color: #f4f3ef;
            }

            .scrollable-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .scrollable-table img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }

            table {
                width: 100%;
                text-align: center;
                border-collapse: collapse;
                border-radius: 10px;
            }

            table img {
                height: 40px;
                width: 40px;
                border-radius: 50%;
            }

            form button {
                display: flex;
                background: none;
                border: none;
                cursor: pointer;
                align-items: center;
            }

            form span {
                font-size: 18px;
                margin-left: 5px;
            }

            #logoutMessage {
                display: none;
                color: red;
                font-size: 18px;
                margin: 20px;
                text-align: center;
            }


            /* PROGRESS BAR DESIGN */

            .scrollable-table {
                height: 80vh;
                overflow-y: auto;
                overflow-x: hidden;
                border: 1px solid #ccc;
                border-radius: 10px;
            }
            .proBar h4
            {
                margin: 5px;
                margin-top: 10px;
                font-style: italic;
            }
            #editbtn{
                text-decoration: none;
                color: white;
            }
        </style>


    </head>
    <body>
        <%

            response.setHeader("Cache-Control", "no-cashe , no-store ,must-revalidate");
            if (session.getAttribute("id") == null) {
                response.sendRedirect("YouAreLogOut.jsp?logoutId=hod");
            } else {

        %>




        <%        Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            String tname = null, base64Image = "",hodProfile="";
            byte[] imgData;
            int count = 0, tcount = 0, total = 0;

            try {

                connection = database_Connection.getConnection();

                if (connection != null) {
                    st = connection.createStatement();

                    int userId = Integer.parseInt(session.getAttribute("id").toString());

                    String sql = "select * from teacher where tid=" + userId;
                    rs = st.executeQuery(sql);
                    if (rs.next()) {

                        byte[] imageData = rs.getBytes("img");
                        base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                        hodProfile=base64Image;
                        
                        tname = rs.getString("tname");
                    }

                    String sql2 = "Select count(sId)  from student";
                    rs = st.executeQuery(sql2);
                    if (rs.next()) {
                        count = rs.getInt(1);
                    }

                    String sql3 = "Select count(tId)  from teacher";
                    rs = st.executeQuery(sql3);
                    if (rs.next()) {
                        tcount = rs.getInt(1);
                        tcount -= 1;
                    }
                    total = count + tcount;

                } else {
                    out.print("bd fail");
                }

            } catch (Exception e) {
                out.println("<p>An error occurred. Please try again later.</p>" + e);
            }

        %>        
        <div class="navmain">
            <div class="profile">
                <%if (base64Image != null) {%>
                <img src="data:image/jpeg;base64,<%= base64Image%>" id="logo" alt="">
                <%} else {
                %>
                <img src="images/user.png" id="logo" alt="">
                <%}%>
                <h3><%= tname%></h3>
                <a id="editbtn" href="hod_EditProfile.jsp"><button> Edit </button></a>
            </div>
            <hr>
            <div class="navbaroption">
                <a href="#" id="Dashboard"> <img src="images/dashboard.png" alt="">Dashboard</a>
                <a href="hod_Classes.jsp"> <img src="images/presentation.png" alt="">Classes</a>
                <a href="hod_Teacher.jsp"> <img src="images/training.png" alt="">Teachers</a>
                <a href="hod_TimeTable.jsp"> <img src="images/calendar-clock.png" alt="">Time Tables</a>
                <a href="hod_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a>

                <form    onsubmit="return logout()" action="Logout">
                    <button type="submit">
                        <input type="hidden" value="0" name="Log" >
                        <img src="images/signout.png" alt="Sign Out">
                        <span>Logout</span>
                    </button>
                </form>


            </div>
        </div>
        <div class="mainbody">

            <div class="top">
                <h2>Dashboard</h2>

                <!--CALCULATIONS FOR CALCULATING THE PERCENTAGE OF PRESENT TEACHERS--> 
                <%
                    PreparedStatement totalStmt = null;
                    PreparedStatement presentStmt = null;
                    ResultSet totalRs = null;
                    ResultSet presentRs = null;

                    String totalQuery = "SELECT COUNT(*) FROM teacher WHERE verified = '1'";
                    totalStmt = connection.prepareStatement(totalQuery);
                    totalRs = totalStmt.executeQuery();
                    int totalTeachers = 0;
                    if (totalRs.next()) {
                        totalTeachers = totalRs.getInt(1);
                    }
                    
                    String totalQuery2 = "SELECT COUNT(*) FROM student";
                    totalStmt = connection.prepareStatement(totalQuery2);
                    totalRs = totalStmt.executeQuery();

                    int totalStudents = 0;
                    if (totalRs.next()) {
                        totalStudents = totalRs.getInt(1);
                    }

                    

                    // Query to get present verified teachers on 2025-03-24
                    String presentQuery = "SELECT COUNT(DISTINCT teacher_id) FROM attendance WHERE teacher_id IN (SELECT tId FROM teacher WHERE verified = '1') AND date = '2025-03-24'";
                    presentStmt = connection.prepareStatement(presentQuery);
                    presentRs = presentStmt.executeQuery();

                    int presentTeachers = 0;
                    if (presentRs.next()) {
                        presentTeachers = presentRs.getInt(1);
                    }
                    
                    
                     String presentQuery2 = "SELECT COUNT(DISTINCT student_id) FROM attendance WHERE date = '2025-03-24'";
                    presentStmt = connection.prepareStatement(presentQuery2);
                    presentRs = presentStmt.executeQuery();

                    int presentStudents = 0;
                    if (presentRs.next()) {
                        presentStudents = presentRs.getInt(1);
                    }
                    

                   

                %>
            </div>
            <div class="dashboard">
                <div class="container_1">
                    <img src="images/graduates.png" id="student" alt="">

                    <div class="proBar">
                        <h4>total : <%= totalStudents %></h4>
                        ____________
                        <h4>present today: <%= presentStudents %></h4>
                    </div>

                </div>
                <div class="container_2">
                    <img src="images/teacher (1).png" id="teacher" alt="">

                   <div class="proBar">
                        <h4>total : <%= totalTeachers %> </h4>
                        ____________
                        <h4>present today : <%= presentTeachers %></h4>
                    </div>
                </div>
                <div class="container_3">
                    <h1>Total</h1>

                    <div class="cont_3">
                        <img src="images/teacher (1).png" id="totalTeacher" alt="">
                        <p>+</p>

                        <img src="images/check.png" id="totalStudent" alt="">
                    </div>
                    <label><%= totalTeachers + totalStudents %></label>
                    <h3 style="font-style: italic; margin-top: 5px;">Overall</h3>
                </div>
            </div>
            <h2>Daily Report</h2>

            <div class="tblmain">
                <div class="scrollable-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Profile</th>
                                <th>Name</th>
                                <th>Class Name</th>
                                <th>Status</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                PreparedStatement pst = null;

                                try {
                                    String query = """
                                        SELECT 
                                            t.tId, 
                                            t.tName, 
                                            COALESCE(c.className, 'N/A') AS className, 
                                            CASE 
                                                WHEN NOW() BETWEEN tt.startTime AND tt.endTime 
                                                    THEN 'Teaching' 
                                                WHEN NOW() < tt.startTime 
                                                    THEN 'Upcoming' 
                                                ELSE 'Completed' 
                                            END AS status, 
                                            tt.startTime, 
                                            tt.endTime 
                                        FROM timetable tt
                                        JOIN teacher t ON tt.tId = t.tId
                                        LEFT JOIN classes c ON tt.clsId = c.classId
                                        WHERE tt.day = DAYNAME(CURDATE())  -- Fetches only today's records
                                        ORDER BY tt.startTime;
                                    """;

                                    pst = connection.prepareStatement(query);
                                    rs = pst.executeQuery();

                                    if (!rs.isBeforeFirst()) {
                                        // No records found
                                        out.println("<tr><td colspan='6' style='text-align: center;'>No timetable is available</td></tr>");
                                    } else {
                                        while (rs.next()) {
                                            String teacherName = rs.getString("tName");
                                            String className = rs.getString("className");
                                            String status = rs.getString("status");
                                            String startTime = rs.getString("startTime");
                                            String endTime = rs.getString("endTime");
                            %>
                            <tr>
                                <td><img src="images/check.png" alt="Profile"></td>
                                <td><%= teacherName%></td>
                                <td><%= className%></td>
                                <td><%= status%></td>
                                <td><%= startTime%></td>
                                <td><%= endTime%></td>
                            </tr>
                            <%
                                        }
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='6' style='text-align: center; color: red;'>Error: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (pst != null) {
                                        pst.close();
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>



        </div> 

        <%
                st.close();
                connection.close();

            }
        %>
    </body>
</html>
