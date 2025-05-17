<%@page import="java.time.format.TextStyle"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@ page import="java.sql.*, db.database_Connection,java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Index Student </title>
    <head>
        <style>

body{
                height: 100vh;
                width: 100%;
                overflow: hidden;
                font-family: 'Roboto', Arial, sans-serif;
           
                padding: 0px;
                
            }
            /* side navigation bar css */
            .navmain
            {
                height: 93vh;
                width: 17%;
                float: left;
                padding: 20px;
                background: linear-gradient(#eacda3 , #d6ae7b);
                border-radius: 5px;
            }
            .profile
            {
                height: 15vh;
                width: 85%;
                text-align: center;
                padding: 20px;
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
                border-radius: 50px;
                border: 1px solid #6bbbed;
            }
            hr
            {
                border: none;
                height: 3px;
                background-color: white; /* Adjust to your color */
                margin: 10px 0;
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
                color: whitesmoke;
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
                background: whitesmoke;
                transition: width 0.3s ease;
            }

            .navbaroption a:hover::after {
                width: 100%;
            }

            .navbaroption a:hover {
                color: white; /* Hover color */
            }

            .navbaroption img {
                height: 0.8cm;
                width: 0.8cm;
                display: block; /* Ensures the image behaves like a block element */
            }

            #Dashboard
            {
                color: whitesmoke;
                /*                text-decoration: underline #0d6efd;
                                text-underline-offset: 5px;*/
            }
        
            /* main interface ui css */

            .mainbody
            {
                background-color: #f4f3ef;
                height: 100vh;
                width: 80%;
                margin-left:20%;
                padding: 10px;
               
            }
            h2{
                color: #0d6efd;
                justify-content: center;
                text-align: center;
            }
            .dashboard
            {
                background: linear-gradient(#26baee,#9fe8fa );
                /* background: linear-gradient(#fdeb71,#f8d800 ); */
                height: 15vh;
                display: flex;
                justify-content: space-evenly;
                padding: 20px;
                /* background: #d5f3fe; */
                width: 54%;
                border-radius: 5px;
                margin-left: 25%;
                margin-top: 1px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.10);
                padding-right: 15%;
            }
            label
            {
                font-weight: bold;
                margin: 20px 38px 38px 35px;
                font-size: 25px;
            }

            /* TABLE MAIN CSS OUTLINE */
            .tblmain
            {
                padding: 20px;
                background: white;
                border-radius: 10px;
                width: 88%;
                height: 50vh;
                margin-left: 3%;
                padding: 30px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.20);
            }
            table th
            {
                height: 50px;
                background: #6bbbed;
            }

            /* MAIN TABLE */
            table
            {
                width: 100%;
                text-align: center;
                border-collapse: collapse;
                border-radius:10px;
                height: 40vh;
                padding: 10px;
                margin-top: 5%;
            }
            table  tr:nth-child(odd) {
                background-color: #f4f3ef;
            }
            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            table td
            {
                padding: 10px;
            }
            table img{
                height: 1.5cm;
                width: 1.5cm;
                border-radius: 25px;
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
            #logoutMessage {
                display: none;
                color: red;
                font-size: 18px;
                margin: 20px;
            }


            /* Marks Desing  */

    /* Container to hold the mark box */
    .marks-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    background: linear-gradient(#26baee,#9fe8fa );
      background-color: #fff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      border-radius: 15px;
      padding: 50px;
      width: 60px;
      height:70px;
      text-align: center;
      float: left;
      margin-left:3%;
    
    }

    /* Title of the box */
    .title {
      font-size: 15px;
      font-weight: bold;
      color: #333;
      margin-bottom: 3px;
    }

    /* Style for the obtained value */
    .obtained-value {
      font-size: 18px;
      font-weight: bold;
      color: #4CAF50;
      margin-bottom: 5px;
      padding: 15px;
      background-color: #e8f5e9;
      border-radius: 50%; /* No rounding */
      width: auto;
      height: auto;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Style for the total value */
    .total-value {
      font-size: 18px;
      font-weight: normal;
      color: #2196F3;
      padding: 10px;
      background-color: #e3f2fd;
      border-radius: 50%; /* No rounding */
      width: auto;
      height: auto;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-top: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Decorative line for separation */
    
    #markshr
    {
        height: 5px;
        width: 100%;
        color: gray;
    }

    /* PROGRESS BAR */
    
      /* Style for the progress container */
      .progress-container {
      width: 100%;
      background-color: #f3f3f3;
      border-radius: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
     margin-top: 45px;
      height: 30px;
        margin-left: 30px;
      position: relative;
    }
    .progress-container 

    /* Style for the progress bar itself */
    .progress-bar {
      width: 0;
      height: 100%;
      border-radius: 20px;
      text-align: center;
      line-height: 20px;
      color: white;
      font-weight: bold;
      transition: width 0.5s ease-in-out;
      position: relative;
    }
   

    /* The percentage number inside the progress bar */
    .percentage {
      position: absolute;
      left: 10px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 10px;
      font-weight: normal;
      color: white;
    }

    /* Container for the two bars side by side */
    .progress-wrapper {
      display: flex;    
      width: 80%;
      max-width: 900px;
      margin-left: 0px auto;
    }
    #weeklyBar
    {
        margin-left: 1%;
    }
    .dataname
    {
        height: 30px;
        display: flex;
    }
    p{
        margin-left: 160%;
        font: bold;
    }
    /* FULL TIME TABLE */
    .fullTimeTable
    {
        height: auto;
        width: 93%;
        padding: 20px;
       background: white;
       box-shadow: 0 4px 8px rgba(0, 0, 0, 0.30);
    }


    .threeD-btn {
    background: #1e90ff;
    border: none;
    color: white;
    padding: 12px 24px;
    font-size: 16px;
    font-weight: bold;
    border-radius: 10px;
    cursor: pointer;
    transition: 0.2s ease;
    box-shadow: 0 4px #0d6efd;
}

.threeD-btn:active {
    box-shadow: 0 2px #0d6efd;
    transform: translateY(2px);
}     
        </style>
    </head>
    <script>
        function logout()
        {
            return confirm("Are you sure You want to Logout ?");
        }
    </script>
    
</head>
<body>
    
    <%

        response.setHeader("Cache-Control", "no-cashe , no-store ,must-revalidate");
        if (session.getAttribute("id") == null) {
          response.sendRedirect("YouAreLogOut.jsp?logoutId=student");
        }
        else
        {
        
        
        
        Connection connection = null;
        Statement st = null;
        ResultSet rs = null;
        String tname = null;
        PreparedStatement pst = null;
        String className="",base64Image="";
        byte[] imgData;
        int count = 0, tcount = 0, total = 0 ,status=0,sId=0;

        try {

            connection = database_Connection.getConnection();
            st = connection.createStatement();

            if (connection != null) {
                

                int userId = Integer.parseInt(session.getAttribute("id").toString());
                sId=userId;

                String sql = "select * from student where sId=" + userId;
                rs = st.executeQuery(sql);
                if (rs.next()) {
                    tname = rs.getString("sName");
                    className=rs.getString("sClass"); 
                    status=rs.getInt("requested");
                    
                    byte[] imageData = rs.getBytes("img");

                    if (imageData != null) {
                        base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                    } else {
                        base64Image = ""; // Or provide a default image
                    }
                    
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
                    <img src="data:image/jpeg;base64,<%= base64Image%>" id="logo" alt="" name="photo">
                    <%} else {
                    %>
                    <img src="images/user.png" id="logo" alt="" photo="photo">
                    <%}%>
                <h4><%= tname%></h4>
            </div>


        <hr>
        <div class="navbaroption">
            <a href="#" id="Dashboard"> <img src="images/dashboard.png" alt="">Home</a>
            
            <a href="student_Attendance.jsp?id="+> <img src="images/user-check.png" alt="">Attendance</a>
            <a href="student_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a>
           

            <form    onsubmit="return logout()" action="Logout">
                <button type="submit">
                    <img src="images/signout.png" alt="Sign Out">
                    <input type="hidden" value="1" name="stuLogin">
                    <span>Logout</span>
                </button>
            </form>
        </div>
    </div>
    <div class="mainbody">

        <h2 id="h3" style="display: none;">Time Table</h2>
        <div class="fullTimeTable" id="fullTimeTable" style="display: none;">
        
            <button onclick="smallView()" class="threeD-btn">Preview</button>
           <% 
            String sqlTimeSlots = "SELECT DISTINCT t.startTime, t.endTime " +
                          "FROM timetable t " +
                          "JOIN classes c ON t.clsId = c.classId " +
                          "WHERE c.className = ? ORDER BY t.startTime";
    PreparedStatement pstmtTimeSlots = connection.prepareStatement(sqlTimeSlots);
    pstmtTimeSlots.setString(1, className);
    ResultSet rsTimeSlots = pstmtTimeSlots.executeQuery();

    // Store time slots in an ArrayList
    java.util.List<String> timeSlots = new java.util.ArrayList<>();
    while (rsTimeSlots.next()) {
        timeSlots.add(rsTimeSlots.getTime("startTime") + " - " + rsTimeSlots.getTime("endTime"));
    }

    // Step 2: Prepare all days of the week
    String[] daysOfWeek = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
%>

<table border="1">
    <thead>
        <tr>
            <th>Day/Time</th>
            <% for (String slot : timeSlots) { %>
                <th><%= slot %></th>
            <% } %>
        </tr>
    </thead>
    <tbody>
        <% 
            // Step 3: Loop through each day of the week
            for (String day : daysOfWeek) {
                out.print("<tr><td>" + day + "</td>");

                // Step 4: Loop through each time slot
                for (String slot : timeSlots) {
                    String[] times = slot.split(" - ");
                    Time startTime = Time.valueOf(times[0]);
                    Time endTime = Time.valueOf(times[1]);

                    // Query to find subject & teacher for this day & time slot
                    String sqlSubject = "SELECT s.subName, t.tName FROM timetable tt " +
                                        "JOIN subjects s ON tt.subId = s.subId " +
                                        "JOIN teacher t ON tt.tId = t.tId " +
                                        "JOIN classes c ON tt.clsId = c.classId " +
                                        "WHERE c.className = ? AND tt.day = ? AND tt.startTime = ? AND tt.endTime = ?";
                    PreparedStatement pstmtSubject = connection.prepareStatement(sqlSubject);
                    pstmtSubject.setString(1, className);
                    pstmtSubject.setString(2, day);
                    pstmtSubject.setTime(3, startTime);
                    pstmtSubject.setTime(4, endTime);
                    ResultSet rsSubject = pstmtSubject.executeQuery();

                    String subjectName = "N/A";
                    String teacherName = "N/A";
                    if (rsSubject.next()) {
                        subjectName = rsSubject.getString("subName");
                        teacherName = rsSubject.getString("tName");
                    }

                    out.print("<td>" + subjectName + "<br><small>(" + teacherName + ")</small></td>");
                }
                out.print("</tr>");
            }
        %>
    </tbody>
</table>
        
        </div>
        
  
            <h2 id="att">My Attendance</h2>

        <!-- Marks Design -->
<!--            <div class="marks-container" id="marksId">
                <div class="title">Today</div>
                <div class="obtained-value" id="obtained">85</div>  Obtained Value 
                ________
                <div class="total-value" id="total">100</div>  Total Value 
              </div>-->
        <div class="dashboard" id="progressId">
            <div class="dataname">
                <P>Weekly</P>
                <P>Monthly</P>
            </div>
            
            <div class="progress-wrapper">
                <!-- Weekly Attendance Progress Bar -->
                <div class="progress-container">
                  <div id="weeklyBar" class="progress-bar">
                    <span class="percentage">0%</span> <!-- Percentage text inside the bar -->
                  </div>
                </div>
                
            
                <!-- Monthly Attendance Progress Bar -->
                <div class="progress-container">
                  <div id="monthlyBar" class="progress-bar">
                    <span class="percentage">0%</span> <!-- Percentage text inside the bar -->
                  </div>
                </div>
              </div>

              
        </div> 
        <h2 id="tdyses">Todays Sessions</h2>

        <div class="tblmain" id="tableId">

            <!--<button onclick="fullview()"  class="threeD-btn">Full Time Table</button>-->
            
    <%
    String todayDay = "";
    boolean firstRow = true;
   String currentDay = LocalDate.now().getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH);

    // Get the current day name
    String queryDay = "SELECT DAYNAME(CURDATE()) AS todayDay";
    pst = connection.prepareStatement(queryDay);
    rs = pst.executeQuery();
    if (rs.next()) {
        todayDay = rs.getString("todayDay");
    }

    String query2 = "SELECT t.day, t.startTime, t.endTime, c.className, s.subName, te.tName AS teacherName " +
                    "FROM timetable t " +
                    "JOIN classes c ON t.clsId = c.classId " +
                    "JOIN subjects s ON t.subId = s.subId " +
                    "JOIN teacher te ON t.tId = te.tId " +
                    "WHERE c.className = ? AND t.day = ? ";

//    String dayy = "Thursday"; // Get current day dynamically
// "
    pst = connection.prepareStatement(query2);
    pst.setString(1, className);
   pst.setString(2, currentDay);
    rs = pst.executeQuery();
    
    // Get current time
    java.time.LocalTime currentTime = java.time.LocalTime.now();
%>

<table border="1">
    <tr>
        <th>Day</th>
        <th>Time</th>
        <th>Teacher</th>
        <th>Subject</th>
        <th>Attendance</th>
    </tr>

    <%
        boolean hasData = false;
        while (rs.next()) {
            
            
        
            hasData = true;
            String day = rs.getString("day");
            String startTime = rs.getString("startTime");
            String endTime = rs.getString("endTime");
            String teacher = rs.getString("teacherName");
            String subject = rs.getString("subName");

            // Convert database time to LocalTime for comparison
            java.time.LocalTime start = java.time.LocalTime.parse(startTime);
            java.time.LocalTime end = java.time.LocalTime.parse(endTime);

            // Check if current time is within the time slot
            boolean isActive = !currentTime.isBefore(start) && !currentTime.isAfter(end);
    %>

    <tr>
        <td><%= firstRow ? day : "" %></td> <!-- Show day only in the first row -->
        <td><%= startTime %> - <%= endTime %></td>
        <td><%= teacher %></td>
        <td><%= subject %></td>
      <td>
    <%
        // Use a separate ResultSet for student query
        ResultSet studentRs = st.executeQuery("SELECT * FROM student WHERE sId=" + sId);
        if (studentRs.next()) {
            tname = studentRs.getString("sName");
            className = studentRs.getString("sClass");
            status = studentRs.getInt("requested");
        }

        // Display button based on time and status
        if (isActive) {
            if (status == 1) {
    %>
                <button class="threeD-btn" disabled>Marked</button>
    <%
            } else if (status == 0) {
    %>
                <form action="markAttendance" method="post" style="margin: 0;">
                    <input type="hidden" name="sId" value="<%= sId %>">
                    <button type="submit" class="threeD-btn">Mark Attendance</button>
                </form>
    <%
            }
        } else {
    %>
            <button class="threeD-btn" disabled>Not Available</button>
    <%
        }
    %>
</td>


        </td>
    </tr>

    <%
            firstRow = false; // Hide the day after the first row
        }

        if (!hasData) {
    %>
    <tr>
        <td colspan="5">No classes today (<%= currentDay %>)</td>
    </tr>
    <%
        }
    %>
</table>


        </div>
    </div> 
            <script>

            
            function fullview()
            {
                var mark=document.getElementById("marksId");
             var dash=document.getElementById("progressId");
            var tbl=document.getElementById("tableId");
            var full=document.getElementById("fullTimeTable");
            var h1=document.getElementById("tdyses");
            var h2=document.getElementById("att");
            var h3=document.getElementById("h3");   

                mark.style.opacity="0";
                // mark.style.display="none";
                h1.style.display="none";
                h2.style.display="none";
                dash.style.display="none";
                tbl.style.display="none";
                full.style.display="block";
                h3.style.display="block";
            }
           function smallView()
            {
                var mark=document.getElementById("marksId");
             var dash=document.getElementById("progressId");
            var tbl=document.getElementById("tableId");
            var full=document.getElementById("fullTimeTable");
            var h1=document.getElementById("tdyses");
            var h2=document.getElementById("att");
            var h3=document.getElementById("h3");

            mark.style.opacity="1";
                h1.style.display="block";
                h2.style.display="block";
                dash.style.display="block";
                tbl.style.display="block";
                full.style.display="none";
                h3.style.display="none";
            }



        </script>
         <script>
              
                var obtained = 85;  
                var total = 100;   
                
               
                document.getElementById('obtained').textContent = obtained;
                document.getElementById('total').textContent = total;
              </script>
              <script>
               
                var weeklyValue = 70;  
                var monthlyValue = 90; 
            
                
                function moveProgressBar(barId, value) {
                  var elem = document.getElementById(barId);
                  var width = 0;
                  var percentageElem = elem.querySelector('.percentage'); 
            
                  var interval = setInterval(function() {
                    if (width >= value) {
                      clearInterval(interval);
                    } else {
                      width++;
            
                      
                      if (width < 50) {
                        elem.style.backgroundColor = '#B9000A'; 
                      } else if (width >= 50 && width <= 80) {
                        elem.style.backgroundColor = '#F79802'; 
                      } else if (width > 80) {
                        elem.style.backgroundColor = '#60A23C'; 
                      }
            
                      elem.style.width = width + '%';
                      percentageElem.innerHTML = width + '%'; 
                    }
                  }, 8); 
                }
            
               
                moveProgressBar('weeklyBar', weeklyValue);
                moveProgressBar('monthlyBar', monthlyValue);
              </script> 
    <%
        st.close();
        connection.close();
        }
    %>
</body>
</html>


