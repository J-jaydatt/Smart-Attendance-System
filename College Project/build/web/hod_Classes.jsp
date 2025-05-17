<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Class Tab Hod</title>
        <script>
            function logout()
            {
                return confirm("Are you sure You want to Logout ?")
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
                border-radius: 50px;
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
            }
            #topOption{
                margin-top: 20px;
            }
            /* main interface ui css */

            .mainbody
            {
                background-color: #f4f3ef;
                height: auto;
                width: 77%;
                margin-left:20%;
                padding: 20px;
            }
            h2{
                color: #0d6efd;
            }

            /* TABLE MAIN CSS OUTLINE */
            .tblmain
            {
                padding: 20px;
                background: white;
                border-radius: 10px;
                height: auto;
            }
            .tblmain img
            {
                height: 1cm;
                width: 1cm;
                font-size: 30px;
                margin: 10px;
                color: #0d6efd;
            }

            table th
            {
                height: 40px;
                background: #6bbbed;
            }

            /* MAIN TABLE */
            table
            {
                width: 100%;
                text-align: center;
                border-collapse: collapse;
                border-radius:10px;
                height: auto;

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
                border-radius: 50px;
                margin-top: 10%;
            }
            table button
            {
                background-color: orange;
                color: whites;
                border: none;
                height: 30px;
                border-radius: 10px;
            }
            #lg{
                margin-top: 35%;
                display: flex;
                background: none;
                border:none
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
            #addClass
            {
                display: inline-block;
                color: orange;
                background: linear-gradient(to right, #fa4649, #e9007f);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                font-size: 20px;
                font-weight: bold;
            }
            #add
            {
                margin-top: 20px;
                background: none;
                border: none;
            }
            .adding
            {
                display: flex;
                align-items: center;
            }
            #logoutMessage {
                display: none;
                color: red;
                font-size: 18px;
                margin: 20px;
            }
            .scrollable-table {
                height: 80vh; 
                overflow-y: auto; 
                overflow-x: hidden; 
                border: 1px solid #ccc; 
                border-radius: 10px; 
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

        <%            Connection connection = null;
            Statement st = null;
            ResultSet rs = null;
            String name = "", base64Image = "";
            connection = database_Connection.getConnection();
            int addId = 1;

            st = connection.createStatement();

            if (session.getAttribute("id") == null) {

            } else {
                int userId = Integer.parseInt(session.getAttribute("id").toString());

                String sql = "select * from teacher where tid=" + userId;
                rs = st.executeQuery(sql);
                while (rs.next()) {

                    byte[] imageData = rs.getBytes("img");
                    base64Image = java.util.Base64.getEncoder().encodeToString(imageData);

                    name = rs.getString("tname");

                }
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
                <h3><%= name%></h3>
                <a id="editbtn" href="hod_EditProfile.jsp"><button> Edit </button></a>
            </div>
            <hr>
            <div class="navbaroption">
                <a href="hod_Index.jsp" id="topOption" > <img src="images/dashboard.png" alt="">Dashboard</a>
                <a href="#" id="Dashboard"> <img src="images/presentation.png" alt="">Classes</a>
                <a href="hod_Teacher.jsp"> <img src="images/training.png" alt="">Teachers</a>
                <a href="hod_TimeTable.jsp"> <img src="images/calendar-clock.png" alt="">Time Tables</a>
                <a href="hod_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a
                <div>
                    <form  onsubmit="return logout()" action="Logout">
                        <button type="submit">


                            <input type="hidden" value="0" name="Log" >
                            <img src="images/signout.png" alt="Sign Out">
                            <span>Logout</span>  
                        </button>
                    </form>
                </div>   
            </div>

        </div>
        <div class="mainbody">
            <h2>Dashboard</h2>

            <div class="tblmain">
                <div class="scrollable-table">
                    <table>
                        <tr>
                            <th>Class</th>
                            <th>Class Teacher</th>
                            <th>Strength</th>
                            <th>Data</th>
                        </tr>
                        <%
                            String sql2 = "select * from classes";
                            rs = st.executeQuery(sql2);
                            while (rs.next()) {
                                String className = rs.getString("className");
                        %>
                        <tr>
                            <td><%= rs.getString("className")%></td>
                            <td><%= rs.getString("classTeacher")%></td>
                            <td><%= rs.getInt("strength")%></td>
                        <form method="post" action="hod_ClassRecords.jsp"> 
                            <td><button type="submit">View Records</button></td>
                            
                            <input  type="hidden" name="teacherName" value="<%= rs.getString("classTeacher")%>">
                            <input  type="hidden" name="className" value="<%= className%>"> 
                        </form>

                        </tr>
                        <%
                            }

                            st.close();
                            connection.close();
                        %>
                    </table>
                    <div class="adding">
                        <form action="hod_AddClass.jsp" method="POST">
                            <button id="add" type="submit"> <img src="images/plus (1) 2.png" alt=""></button>
                            <p id="addClass">Add a Class</p>
                            <input type="hidden" name="addId" value="<%= addId%>">
                        </form>
                    </div>
                </div>
            </div>


        </div>
        <%
            }
        %>          
    </body>
</html>
