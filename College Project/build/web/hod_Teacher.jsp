<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement,java.sql.Time, java.sql.PreparedStatement,db.database_Connection" %>
<%--<%@ page import="java.sql.*, db.database_Connection" %>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher Tab Hod Page</title>
        
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
            height: 100vh;
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
        }
        .tblmain button
        {
            height: 30px;
            margin: 10px;
            background: #0d6efd;
            border: none;
            border-radius: 10px;
            color: white;
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
            padding: 5px;
        }
        table img{
            height: 1cm;
            width: 1cm;
            border-radius: 25px;
        } 
        table button
        {
            background-color: orange;
            color: whites;
            border: none;
            height: 30px;
            border-radius: 10px;
            width: 40%;
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
    

    </style>
    </head>
    <body>
        <%

        response.setHeader("Cache-Control", "no-cashe , no-store ,must-revalidate");
        if (session.getAttribute("id") == null) {
            response.sendRedirect("YouAreLogOut.jsp?logoutId=hod");
        } else {

    %>

        
        <% 
        
        Connection connection = null;
        Statement st = null;
        PreparedStatement psmt= null;
        ResultSet rs=null;
        String name="",verified="1",base64Image="",hodProfile="";
        
            connection = database_Connection.getConnection();
           
                st = connection.createStatement();
                
                if(session.getAttribute("id")==null)
                    {
                    
                     }
                     else 
                     {
                    int userId = Integer.parseInt(session.getAttribute("id").toString());
                    
                    String sql ="select * from teacher where tid="+userId;
                    rs=st.executeQuery(sql);
                    while(rs.next())
                    {
                        byte[] imageData = rs.getBytes("img");
                        base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                        hodProfile=base64Image;
                        name=rs.getString("tName");
                        
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
                <a href="hod_Classes.jsp" > <img src="images/presentation.png" alt="">Classes</a>
                <a href="#" id="Dashboard"> <img src="images/training.png" alt="">Teachers</a>
                <a href="hod_TimeTable.jsp"> <img src="images/calendar-clock.png" alt="">Time Tables</a>
                <a href="hod_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a
                <div>
                    <form  onsubmit="return logout()" action="Logout">
                        <button type="submit">


                            <input type="hidden" value="0" name="hod" >
                            <img src="images/signout.png" alt="Sign Out">
                            <span>Logout</span>  
                        </button>
                    </form>
                </div>   
            </div>
    <div class="mainbody">
        <h2>Verified Teacher</h2>

        <div class="tblmain">
            <table>
                <tr>
                    <th>Profile</th>
                    <th>Teacher Name</th>
                    <th>Contact</th>
                    <th>Email</th>
                    <th>View</th>
                </tr>
                <%
                 String sql2="select * from teacher where verified=?";
                        psmt=connection.prepareStatement(sql2);
                        psmt.setString(1,verified);
                        rs=psmt.executeQuery();
                        while(rs.next())
                        {
                %>
                        
                         
                <tr>
                    <td><img src="images/user.png"></td>
                    <td><%= rs.getString("tName") %></td>
                    <td><%= rs.getString("tContact")%></td>
                    <td><%= rs.getString("tEmail")%></td>
                <form action="hod_TeacherDetails.jsp" method="post">
                    <td><button>Details</button></td>
                    <input type="hidden" value="<%= rs.getInt("tId") %>" name="tId">
                    <input type="hidden" value="<%= userId %>" name="hodId">
                </form>
                </tr>
                <%
                    }
                    }
                    st.close();
                    connection.close();
                %>
            </table>
           <a href="hod_TeacherRequests.jsp"> <button >View Requests</button></a>
        </div>

    </div>
      <%}%>
    </body>
</html>
