<%-- 
   Document   : teacher_MyClass
   Created on : 12 Mar 2025, 11:49:59 pm
   Author     : jay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.sql.PreparedStatement,db.database_Connection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher My Class</title>
        <style>

            body{
                height: 100vh;
                width: 100%;
                overflow: hidden;
                font-family: 'Roboto', Arial, sans-serif;
                padding: 0px;

            }
            .navmain {
                height: 93vh;
                width: 17%;
                float: left;
                padding: 20px;
                background: #ffefe0; /* Soft Peach */
                border-radius: 12px;
                border: 3px solid #ffcaa6; /* Light Orange Border */
                box-shadow: 3px 5px 12px rgba(255, 180, 120, 0.3);
            }

            /* PROFILE SECTION (Solid Background) */
            .profile {
                height: 15vh;
                width: 85%;
                text-align: center;
                padding: 20px;
                border-radius: 10px;
            }

            /* PROFILE BUTTON */
            .profile button {
                background: #ff9f66; /* Soft Orange */
                color: white;
                height: 25px;
                width: 50%;
                border: none;
                border-radius: 20px;
                font-weight: bold;
                transition: all 0.3s ease-in-out;
                cursor: pointer;
            }

            .profile button:hover {
                background: #ff7b42; /* Slightly Darker Orange */
                box-shadow: 0px 4px 10px rgba(255, 120, 60, 0.3);
            }

            /* LOGO */
            #logo {
                height: 2cm;
                width: 2cm;
                background: white;
                padding: 5px;
                border-radius: 50%;
                border: 2px solid #ff9f66;
            }

            /* HORIZONTAL LINE */
            hr {
                border: none;
                height: 2px;
                background-color: #ffcc99;
                margin-top:40px;
            }

            /* NAVBAR OPTIONS */
            .navbaroption {
                margin-top: 5%;
                height: 70vh;
                width: 85%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            /* NAVIGATION LINKS */
            .navbaroption a {
                text-decoration: none;
                color: #8a4f2b; /* Warm Brown */
                font-size: 20px;
                font-weight: bold;
                padding: 15px 0; /* Added space between links */
                display: flex;
                align-items: center;
                gap: 12px;
                position: relative;
                transition: color 0.3s ease-in-out;
                margin-top: 35px;
            }

            /* HOVER EFFECT - Underline */
            .navbaroption a::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 0;
                height: 2px;
                background: #ff7b42; /* Soft Orange */
                transition: width 0.3s ease-in-out;
            }

            .navbaroption a:hover::after {
                width: 100%;
            }

            /* HOVER EFFECT - Color Change */
            .navbaroption a:hover {
                color: #ff7b42;
            }

            /* ICONS INSIDE NAVBAR */
            .navbaroption img {
                height: 24px;
                width: 24px;
            }

            /* ACTIVE DASHBOARD LINK */
            #Dashboard {
                color: #ff7b42;
                font-weight: bold;
            }

            /* main interface ui css */

            .mainbody
            {
                background-color: #ececea;
                height: 100vh;
                width: 80%;
                margin-left:21%;
                padding: 10px;
                border-radius: 10px;


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
            .tblmain {

                padding: 30px;
                background: #f0f5ff; /* Light Blue-Gray */
                border-radius: 12px;
                width: 88%;
                height: auto;
                margin-left: 1.5%;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            }

            /* MAIN TABLE */
            table {
                background: #ffffff; /* Plain White */
                color: #333; /* Dark Text */
                width: 100%;
                text-align: center;
                border-collapse: collapse;
                border-radius: 12px;
                height: auto;
                margin-top: 5%;
                overflow: hidden; /* Ensures rounded corners apply properly */
                border: 1px solid #d1d1d1; /* Light border */
            }

            /* TABLE HEADER */
            table th {
                color: white;
                height: 50px;
                background: #374785; /* Dark Blue */
                font-size: 18px;
                font-weight: bold;
                text-transform: uppercase;
                padding: 12px;
            }

            /* ROW STYLING */
            table tr:nth-child(odd) {
                background-color: #f8f9fc; /* Very Light Blue */
            }

            table tr:nth-child(even) {
                background-color: #e9efff; /* Slightly Darker Blue */
            }

            /* TABLE CELLS */
            table td {
                padding: 15px;
                font-size: 16px;
                font-weight: 500;
                border: 1px solid #ddd; /* Subtle border for better structure */
            }

            /* IMAGE INSIDE TABLE */
            table img {
                height: 40px;
                width: 40px;
                border-radius: 50%;
                border: 2px solid #374785;
                transition: transform 0.3s ease-in-out;
            }

            table img:hover {
                transform: scale(1.1); /* Slight zoom effect */
            }

            /* FORM BUTTON STYLING */
            form button {
                margin-top: 35%;
                display: flex;
                align-items: center;
                background: none;
                border: none;
                cursor: pointer;
                transition: transform 0.2s ease-in-out;
            }

            form button:hover {
                transform: scale(1.05);
            }

            /* FORM ICON/TEXT */
            form span {
                margin-top: 4%;
                font-size: 20px;
                margin-left: 5px;
                font-weight: bold;
                color: #374785; /* Dark Blue */
            }

            #logoutMessage {
                display: none;
                color: red;
                font-size: 18px;
                margin: 20px;
            }
        </style>

    </head>
    <script>
        function logout()
        {
            return confirm("Are you sure You want to Logout ?");
        }
    </script>
    <body>
        <%

            response.setHeader("Cache-control", "no-cache,no-store,must-revalidated");

            if (session.getAttribute("id") == null) {
                response.sendRedirect("YouAreLogOut.jsp?logoutId=teacher");
            } else {
                Connection connection = null;
                Statement st = null;
                PreparedStatement psmt = null;
                ResultSet rs = null, rs2 = null, rs3 = null, rs4 = null;
                String tName = "", className = "";
                int tId = Integer.parseInt(session.getAttribute("id").toString());
                int classId = 0, status = 100;
                String base64Image = "";

                connection = database_Connection.getConnection();

                st = connection.createStatement();

                String sql = "select * from teacher where tId = ?";
                psmt = connection.prepareStatement(sql);
                psmt.setInt(1, tId);
                rs = psmt.executeQuery();
                while (rs.next()) {

                    byte[] imageData = rs.getBytes("img");

                    if (imageData != null) {
                        base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                    } else {
                        base64Image = ""; // Or provide a default image
                    }

                    tName = rs.getString("tName");
                }

                String sql2 = "select clsId from timetable where classTeacherId=?";
                psmt = connection.prepareStatement(sql2);
                psmt.setInt(1, tId);
                rs2 = psmt.executeQuery();
                while (rs2.next()) {
                    classId = rs2.getInt("clsId");
                }

                String sql3 = "select className from classes where classId=?";
                psmt = connection.prepareStatement(sql3);
                psmt.setInt(1, classId);
                rs3 = psmt.executeQuery();
                while (rs3.next()) {
                    className = rs3.getString("className");
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
                <h4><%= tName%></h4>
                <button>Edit</button>
            </div>


            <hr>
            <div class="navbaroption">
                <a href="teacher_Index.jsp" > <img src="images/dashboard.png" alt="">Home</a>

                <a href="#" id="Dashboard"> <img src="images/user-check.png" alt="">My Class</a>
                <a href="teacher_EditProfile.jsp"> <img src="images/setting.png" alt="">Setting</a>


                <form    onsubmit="return logout()" action="Logout">
                    <button type="submit">
                        <img src="images/signout.png" alt="Sign Out">
                        <input type="hidden" value="3" name="Tea">
                        <span>Logout</span>
                    </button>
                </form>
            </div>
        </div>
        <div class="mainbody">

            <h2 id="tdyses">My Class</h2>

                <div class="tblmain" id="tableId">


                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Contact</th>
                            <th>Report</th>
                        </tr>
                        <%
                            String sql4 = "select * from student where sClass=?";
                            psmt = connection.prepareStatement(sql4);
                            psmt.setString(1, className);
                            rs4 = psmt.executeQuery();
                            while (rs4.next()) {
                                status = rs4.getInt("requested");

                        %>
                        <tr>
                            <td><%= rs4.getInt("sId")%></td>
                            <td><%= rs4.getString("sName")%></td>

                            <td>
                                <%= rs4.getString("sContact")%>
                            </td>
                            <td><button>View Report</button></td>
                        </tr>
                        <% }  %>
                    </table>
                </div>
        </div> 



        <%

                st.close();
                connection.close();
            }
        %>
    </body>
</html>
